import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final Api api;

  AuthRepoImpl(this.api);
  @override
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
    // required String city,
  }) async {
    try {
      await api.post(
        token: null,
        url: '$baseUrl/user',
        body: {
          'email': email,
          'password': password,
          'name': name,
          'phoneNumber': phone,
          // 'city': city,
          'roleId': '2',
        },
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail({
    required String email,
  }) async {
    try {
      await api.post(
        token: null,
        url: '$baseUrl/email-verification/send-code',
        body: {'email': email},
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    log(email);
    log(verificationCode);
    try {
      await api.post(
        token: null,

        url: '$baseUrl/email-verification/verify-email',
        body: {'email': email, 'code': verificationCode},
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> login({required String email, required String password}) async{
     try {
      await api.post(
        token: null,
        url: '$baseUrl/auth/login',
        body: {'email': email, 'password': password},
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
    }
}
