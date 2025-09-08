import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/notification/data/models/notification_model.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/entities/notification_entity.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/repos/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final Api _api;

  NotificationRepoImpl(this._api);
  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required BuildContext context,
  }) async {
    try {
      var response = await _api.get(
        url: '$baseUrl/test-notification',
        token: context.read<UserCubit>().currentUser!.accessToken,
      );
      List<NotificationEntity> notifications = [];
      for (var i = 0; i < response.length; i++) {
        notifications.add(NotificationModel.fromJson(response[i]).toEntity());
      }
      return right(notifications);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({
    required BuildContext context,
    required int notificationId,
  }) async {
    try {
      await _api.patch(
        url: '$baseUrl/test-notification/$notificationId/read',
        token: context.read<UserCubit>().currentUser!.accessToken,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
