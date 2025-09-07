import 'package:mwaeed_mobile_app/features/notification/domain/entities/notification_entity.dart';

import 'data_notification_model.dart';

class NotificationModel {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? type;
  DataNotificationModel? data;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  NotificationModel({
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

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      type: json['type'] as String?,
      data: json['data'] == null
          ? null
          : DataNotificationModel.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
    'type': type,
    'data': data?.toJson(),
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'deletedAt': deletedAt,
  };

  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    userId: userId,
    title: title,
    body: body,
    type: type,
    data: data?.toEntity(),
    isRead: isRead,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}
