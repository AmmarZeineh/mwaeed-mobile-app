import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';

abstract class PaymentRepo {
  Future<Either<Failure, List<AppointmentEntity>>> fetchAppointments({
    required BuildContext context,
  });
  Future<Either<Failure, void>> cancelAppointment({
    required BuildContext context,
    required int appointmentId,
  });
}
