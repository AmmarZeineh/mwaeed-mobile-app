import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, void>> addToFavorite({ required BuildContext context, required int providerId});
  Future<Either<Failure, void>> removeFromFavorite({ required BuildContext context, required int providerId});
  Future<Either<Failure, List<ProviderEntity>>> fetchFavoriteProvidersIds({ required BuildContext context});

}