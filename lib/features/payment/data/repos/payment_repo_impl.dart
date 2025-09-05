import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/payment/data/models/appointment_model.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final Api _api;

  PaymentRepoImpl(this._api);
  @override
  Future<Either<Failure, List<AppointmentEntity>>> fetchAppointments({
    required BuildContext context,
  }) async {
    try {
      var response = await _api.post(
        url: '$baseUrl/appointments/by-client',
        token: context.read<UserCubit>().currentUser!.accessToken,
      );
      List<AppointmentEntity> appointments = [];
      for (var i = 0; i < response.length; i++) {
        appointments.add(AppointmentModel.fromJson(response[i]).toEntity());
      }
      return Right(appointments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
