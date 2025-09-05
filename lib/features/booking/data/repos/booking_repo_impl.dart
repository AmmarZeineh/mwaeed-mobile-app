import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/jobs_with_services_model.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/Schedule_model.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/appointment_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';

class BookingRepoImpl implements BookingRepo {
  final Api _api;

  BookingRepoImpl(this._api);

  @override
  Future<Either<Failure, UserJobsResponse>> getJobsWithservice({
    required int id,
  }) async {
    try {
      final data = await _api.get(
        url: '$baseUrl/user/$id/jobs-with-services',
        token: null,
      );

      // بما إنو data هو Map جاهز
      final result = UserJobsResponse.fromJson(data);

      return Right(result);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Appointment>>> getProviderAppointments({
    required int providerId,
    required int jobId,
  }) async {
    try {
      log(providerId.toString());
      log(jobId.toString());
      final data = await _api.post(
        url: '$baseUrl/appointments/by-provider-job',
        body: {"jobId": jobId, "userId": providerId},
        token: null,
      );

      final result = (data as List)
          .map((json) => Appointment.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(result);
    } catch (e, st) {
      log('Error in getProviderAppointments: $e\n$st');
      return Left(ServerFailure(e.toString()));
    }
  }

  /// ⏰ Get Provider Schedule
  @override
  Future<Either<Failure, List<Schedule>>> getProviderSchedule({
    required int providerId,
    required int jobId,
  }) async {
    try {
      final data = await _api.get(
        url: '$baseUrl/availability/id?userId=$providerId&jobId=$jobId',
        token: null,
      );
      log(data.toString());
      final result = (data as List)
          .map((json) => Schedule.fromJson(json))
          .toList();

      return Right(result);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createAppointment({
    required int providerId,
    required int jobId,
    required String appointmentDate,
    required String startTime,
    required String notes,
    required int serviceId,
    required BuildContext context,
  }) async {
    try {
      final body = {
        "appointmentDate": appointmentDate,
        "startTime": startTime,
        "notes": notes,
        "serviceId": serviceId,
        "providerId": providerId,
        "jobId": jobId,
      };

      await _api.post(
        url: '$baseUrl/appointments',
        body: body,
        token: context.read<UserCubit>().currentUser!.accessToken,
      );

      return const Right(null); // ما في داتا نرجعها
    } catch (e, st) {
      log('Error in createAppointment: $e\n$st');
      return Left(ServerFailure(e.toString()));
    }
  }
}
