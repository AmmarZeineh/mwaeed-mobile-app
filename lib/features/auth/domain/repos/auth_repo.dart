import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}
