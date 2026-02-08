import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';

import 'payment_model.dart';

class AppointmentModel {
  int? id;
  int? clientId;
  int? jobId;
  int? providerId;
  int? serviceId;
  DateTime? appointmentDate;
  String? startTime;
  String? endTime;
  String? status;
  String? notes;
  List<PaymentModel>? payments;
  int? totalPaid;
  int? remainingAmount;
  bool? depositPaid;
  bool? isFullyPaid;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppointmentModel({
    this.id,
    this.clientId,
    this.jobId,
    this.providerId,
    this.serviceId,
    this.appointmentDate,
    this.startTime,
    this.endTime,
    this.status,
    this.notes,
    this.payments,
    this.totalPaid,
    this.remainingAmount,
    this.depositPaid,
    this.isFullyPaid,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'] as int?,
        clientId: json['clientId'] as int?,
        jobId: json['jobId'] as int?,
        providerId: json['providerId'] as int?,
        serviceId: json['serviceId'] as int?,
        appointmentDate: json['appointmentDate'] == null
            ? null
            : DateTime.parse(json['appointmentDate'] as String),
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        status: json['status'] as String?,
        notes: json['notes'] as String?,
        payments: (json['payments'] as List<dynamic>?)
            ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPaid: json['totalPaid'] as int?,
        remainingAmount: json['remainingAmount'] as int?,
        depositPaid: json['depositPaid'] as bool?,
        isFullyPaid: json['isFullyPaid'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'jobId': jobId,
    'providerId': providerId,
    'serviceId': serviceId,
    'appointmentDate': appointmentDate?.toIso8601String(),
    'startTime': startTime,
    'endTime': endTime,
    'status': status,
    'notes': notes,
    'payments': payments?.map((e) => e.toJson()).toList(),
    'totalPaid': totalPaid,
    'remainingAmount': remainingAmount,
    'depositPaid': depositPaid,
    'isFullyPaid': isFullyPaid,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  toEntity() {
    return AppointmentEntity(
      id: id ?? 0,
      clientId: clientId ?? 0,
      jobId: jobId ?? 0,
      providerId: providerId ?? 0,
      serviceId: serviceId ?? 0,
      appointmentDate: appointmentDate ?? DateTime.now(),
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      status: status ?? '',
      notes: notes ?? '',
      payments: payments?.map((e) => e.toEntity()).toList() ?? [],
      totalPaid: totalPaid ?? 0,
      remainingAmount: remainingAmount ?? 0,
      depositPaid: depositPaid ?? false,
      isFullyPaid: isFullyPaid ?? false,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
