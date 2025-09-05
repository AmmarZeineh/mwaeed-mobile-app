import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/features/auth/data/models/user_model.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
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
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var data = await api.post(
        token: null,
        url: '$baseUrl/auth/login',
        body: {'email': email, 'password': password, "fcmToken": "5464646"},
      );
      UserEntity userEntity = UserModel.fromJson(data).toEntity();
      Prefs.setString(userKey, jsonEncode(userEntity.toJson()));
      if (context.mounted) {
        context.read<UserCubit>().setUser(userEntity);
      }
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
