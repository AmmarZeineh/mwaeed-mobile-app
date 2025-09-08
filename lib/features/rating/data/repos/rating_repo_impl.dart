import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/rating/data/models/rating_model.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';

class RatingRepoImpl implements RatingRepo {
  final Api _api;

  RatingRepoImpl(this._api);

  @override
  Future<Either<Failure, void>> submitRating({
    required BuildContext context,
    required int appointmentId,
    required int providerId,
    required int rating,
    required String? comment,
  }) async {
    try {
      await _api.post(
        url: '$baseUrl/ratings',
        token: context.read<UserCubit>().currentUser!.accessToken,
        body: {
          "score": rating,
          "comment": comment,
          "providerId": providerId,
          "appointmentId": appointmentId,
        },
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RatingEntity>> getUserRatingForSpicificProvider({
    required BuildContext context,
    required int providerId,
  }) async {
    try {
      return await _api
          .get(
            url:
                '$baseUrl/ratings/client/${context.read<UserCubit>().currentUser!.id}/provider/$providerId',
            token: context.read<UserCubit>().currentUser!.accessToken,
          )
          .then((response) {
            return Right(RatingModel.fromJson(response).toEntity());
          });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editRating({
    required BuildContext context,
    required int providerId,
    required int appointmentId,
    required int rating,
    required int ratingId,
    required String? comment,
  }) async {
    try {
      await _api.patch(
        url: '$baseUrl/ratings/$ratingId',
        token: context.read<UserCubit>().currentUser!.accessToken,
        body: {
          "score": rating,
          "comment": comment,
          "providerId": providerId,
          "appointmentId": appointmentId,
        },
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
