import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/favorite/domain/repos/favorite_repo.dart';
import 'package:mwaeed_mobile_app/features/home/data/models/provider_model.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final Api api;
  FavoriteRepoImpl(this.api);

  @override
  Future<Either<Failure, void>> addToFavorite({
    required BuildContext context,
    required int providerId,
  }) async {
    try {
      return await api
          .post(
            url: '$baseUrl/favorites',
            body: {'providerId': providerId},
            token: context.read<UserCubit>().currentUser!.accessToken,
          )
          .then((value) => Right(null));
    } catch (e) {
      return Future.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorite({
    required BuildContext context,
    required int providerId,
  }) async {
    try {
      return await api
          .delete(
            url: '$baseUrl/favorites/$providerId',
            token: context.read<UserCubit>().currentUser!.accessToken,
          )
          .then((value) => Right(null));
    } catch (e) {
      return Future.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ProviderEntity>>> fetchFavoriteProvidersIds({
    required BuildContext context,
  }) async {
    try {
      final user = context.read<UserCubit>().currentUser;
      final token = user?.accessToken;

      final data = await api.get(url: '$baseUrl/favorites', token: token);

      // DEBUG: لوق شكل الرد الخام عشان تشوف بالضبط الجيسون
      log('fetchFavoriteProvidersIds response: ${data.toString()}');

      // استخراج القائمة بغض النظر إذا الرد كان List أو { data: [...] }
      List<dynamic> items = [];
      if (data == null) {
        items = [];
      } else if (data is List) {
        items = data;
      } else if (data is Map<String, dynamic>) {
        if (data['data'] is List) {
          items = data['data'] as List;
        } else if (data['favorites'] is List) {
          items = data['favorites'] as List;
        } else if (data['results'] is List) {
          items = data['results'] as List;
        } else {
          // في حال الرد مختلف عن المتوقع: حاول نعتبر الـ map نفسه عنصر واحد
          items = [data];
        }
      } else {
        // شكل غير متوقع
        return Left(
          ServerFailure('Unexpected response format from favorites API'),
        );
      }

      final List<ProviderEntity> providers = [];

      for (final rawItem in items) {
        if (rawItem == null) continue;

        if (rawItem is! Map<String, dynamic>) {
          // لو العنصر مش ماب، نكسر منه ونكمل
          log('Skipping non-map item: $rawItem');
          continue;
        }

        final Map<String, dynamic> itemMap = rawItem;

        // نحاول نجيب حقل الـ provider بعدة أسماء شائعة
        final dynamic providerObj =
            itemMap['provider'] ??
            itemMap['providerDto'] ??
            itemMap['providerData'] ??
            itemMap['provider_info'] ??
            itemMap; // fallback: العنصر نفسه ممكن يكون provider

        if (providerObj == null) {
          log('No provider field in favorite item: $itemMap');
          continue;
        }

        if (providerObj is Map<String, dynamic>) {
          try {
            final providerEntity = ProviderModel.fromJson(
              providerObj,
            ).toEntity();
            providers.add(providerEntity);
            log('Loaded favorite provider: ${providerEntity.toString()}');
          } catch (e, st) {
            log(
              'Failed to parse provider JSON: $e\n$st\nproviderObj: $providerObj',
            );
            // استمر لباقي العناصر
            continue;
          }
        } else {
          log('provider field is not a map, skipping: $providerObj');
          continue;
        }
      }

      return Right(providers);
    } catch (e, st) {
      log('Error in fetchFavoriteProvidersIds: $e\n$st');
      return Left(ServerFailure(e.toString()));
    }
  }
}
