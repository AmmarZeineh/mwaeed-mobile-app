import 'package:mwaeed_mobile_app/features/notification/domain/entities/data_notification_entity.dart';

class NotificationEntity {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? type;
  DataNotificationEntity? data;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  NotificationEntity({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.type,
    this.data,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
}
