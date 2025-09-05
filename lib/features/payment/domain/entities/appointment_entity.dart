import 'package:mwaeed_mobile_app/features/payment/domain/entities/payment_entity.dart';

class AppointmentEntity {
  final int id;
  final int clientId;
  final int jobId;
  final int providerId;
  final int serviceId;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String notes;
  final List<PaymentEntity> payments;
  final int totalPaid;
  final int remainingAmount;
  final bool depositPaid;
  final bool isFullyPaid;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentEntity({
    required this.id,
    required this.clientId,
    required this.jobId,
    required this.providerId,
    required this.serviceId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.notes,
    required this.payments,
    required this.totalPaid,
    required this.remainingAmount,
    required this.depositPaid,
    required this.isFullyPaid,
    required this.createdAt,
    required this.updatedAt,
  });
}
