import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/jobs_with_services_model.dart';
import 'package:mwaeed_mobile_app/features/payment/data/models/Schedule_model.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/appointment_model.dart';

abstract class BookingRepo {
  Future<Either<Failure, UserJobsResponse>> getJobsWithservice({
    required int id,
  });
  Future<Either<Failure, List<Appointment>>> getProviderAppointments({
    required int providerId,
    required int jobId,
  });
  Future<Either<Failure, List<Schedule>>> getProviderSchedule({
    required int providerId,
    required int jobId,
  });
  Future<Either<Failure, void>> createAppointment({
    required int providerId,
    required int jobId,
    required String appointmentDate,
    required String startTime,
    required String notes,
    required int serviceId,
    required BuildContext context,
  });
}
