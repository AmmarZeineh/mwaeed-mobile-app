part of 'fetch_appointments_cubit.dart';

@immutable
sealed class FetchAppointmentsState {}

final class FetchAppointmentsInitial extends FetchAppointmentsState {}

final class FetchAppointmentsLoading extends FetchAppointmentsState {}

final class FetchAppointmentsSuccess extends FetchAppointmentsState {
  final List<AppointmentEntity> appointments;

  FetchAppointmentsSuccess(this.appointments);
}

final class FetchAppointmentsFailure extends FetchAppointmentsState {
  final String errMessage;

  FetchAppointmentsFailure(this.errMessage);
}
