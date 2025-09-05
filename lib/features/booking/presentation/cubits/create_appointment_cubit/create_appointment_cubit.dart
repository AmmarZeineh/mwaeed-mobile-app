import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_state.dart';

class CreateAppointmentCubit extends Cubit<CreateAppointmentState> {
  final BookingRepo repository; // استبدل Repository باسم الريبو عندك

  CreateAppointmentCubit(this.repository) : super(CreateAppointmentInitial());

  Future<void> createAppointment({
    required int providerId,
    required int jobId,
    required String appointmentDate,
    required String startTime,
    required String notes,
    required int serviceId,
      required BuildContext context,

  }) async {
    emit(CreateAppointmentLoading());

    final result = await repository.createAppointment(
      providerId: providerId,
      jobId: jobId,
      appointmentDate: appointmentDate,
      startTime: startTime,
      notes: notes,
      serviceId: serviceId,
      context: context,
    );

    result.fold(
      (failure) => emit(CreateAppointmentFailure(failure.message)),
      (_) => emit(CreateAppointmentSuccess()),
    );
  }
}
