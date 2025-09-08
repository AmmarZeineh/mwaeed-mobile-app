import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';

abstract class RatingRepo {
  Future<Either<Failure, void>> submitRating({
    required BuildContext context,
    required int providerId,
    required int appointmentId,
    required int rating,
    required String? comment,
  });
  Future<Either<Failure, RatingEntity>> getUserRatingForSpicificProvider({
    required BuildContext context,
    required int providerId,
  });
}
