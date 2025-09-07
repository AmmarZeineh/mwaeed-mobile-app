import 'package:mwaeed_mobile_app/features/notification/domain/entities/data_notification_entity.dart';

class DataNotificationModel {
  String? serviceName;
  DateTime? appointmentDate;

  DataNotificationModel({this.serviceName, this.appointmentDate});

  factory DataNotificationModel.fromJson(Map<String, dynamic> json) =>
      DataNotificationModel(
        serviceName: json['serviceName'] as String?,
        appointmentDate: json['appointmentDate'] == null
            ? null
            : DateTime.parse(json['appointmentDate'] as String),
      );

  Map<String, dynamic> toJson() => {
    'serviceName': serviceName,
    'appointmentDate': appointmentDate?.toIso8601String(),
  };

  DataNotificationEntity toEntity() => DataNotificationEntity(
    serviceName: serviceName,
    appointmentDate: appointmentDate,
  );
}
