import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';

part 'cancel_appointment_state.dart';

class CancelAppointmentCubit extends Cubit<CancelAppointmentState> {
  CancelAppointmentCubit(this._paymentRepo) : super(CancelAppointmentInitial());

  final PaymentRepo _paymentRepo;

  Future<void> cancelAppointment({
    required context,
    required int appointmentId,
    required String state,
  }) async {
    emit(CancelAppointmentLoading());
    final result = await _paymentRepo.cancelAppointment(
      context: context,
      appointmentId: appointmentId,
    );
    result.fold((failure) => emit(CancelAppointmentFailure(failure.message)), (
      _,
    ) {
      emit(CancelAppointmentSuccess());
    });
  }
}
