import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> updateUserData({
    required Map<String, dynamic> body,
    required int userId,
  });
  Future<Either<Failure, List<CityEntity>>> getCities();

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  });
}
