
abstract class CreateAppointmentState  {
  const CreateAppointmentState();


}

class CreateAppointmentInitial extends CreateAppointmentState {}

class CreateAppointmentLoading extends CreateAppointmentState {}

class CreateAppointmentSuccess extends CreateAppointmentState {}

class CreateAppointmentFailure extends CreateAppointmentState {
  final String message;
  const CreateAppointmentFailure(this.message);

}
