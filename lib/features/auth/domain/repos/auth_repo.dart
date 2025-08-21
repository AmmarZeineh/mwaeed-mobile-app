import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
    // required String city
  });

  Future<Either<Failure, void>> verifyEmail({
    required String email,
    required String verificationCode,
  });

  Future<Either<Failure, void>> resendVerificationEmail({
    required String email,
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
    required BuildContext context
  });
}
