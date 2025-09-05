import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';

part 'fetch_appointments_state.dart';

class FetchAppointmentsCubit extends Cubit<FetchAppointmentsState> {
  FetchAppointmentsCubit(this._paymentRepo) : super(FetchAppointmentsInitial());
  final PaymentRepo _paymentRepo;

  Future<void> fetchAppointments({
    required context,
    required String state,
  }) async {
    emit(FetchAppointmentsLoading());
    final result = await _paymentRepo.fetchAppointments(context: context);
    result.fold((failure) => emit(FetchAppointmentsFailure(failure.message)), (
      appointments,
    ) {
      List<AppointmentEntity> filterdList = _filterByState(appointments, state);
      emit(FetchAppointmentsSuccess(filterdList));
    });
  }
}

List<AppointmentEntity> _filterByState(
  List<AppointmentEntity> originList,
  String desiredState,
) {
  List<AppointmentEntity> filteredList = [];
  for (var appointment in originList) {
    if (appointment.status == desiredState) {
      filteredList.add(appointment);
    }
  }
  return filteredList;
}
