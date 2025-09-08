import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required BuildContext context,
  });

  Future<Either<Failure, void>> markAsRead({
    required BuildContext context,
    required int notificationId,
  });
}
