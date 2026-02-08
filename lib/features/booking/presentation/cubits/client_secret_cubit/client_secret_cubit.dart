import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';

part 'client_secret_state.dart';

class ClientSecretCubit extends Cubit<ClientSecretState> {
  ClientSecretCubit(this._bookingRepo) : super(ClientSecretInitial());

  final BookingRepo _bookingRepo;

  Future<void> fetchClientSecret({
    required BuildContext context,
    required int appointmentId,
    required bool isDeposit,
  }) async {
    emit(ClientSecretLoading());

    final result = await _bookingRepo.fetchSecretKey(
      context: context,
      appointmentId: appointmentId,
      isDeposit: isDeposit,
    );

    result.fold((failure) => emit(ClientSecretFailure(failure.message)), (
      secret,
    ) {
      String clientSecret = secret;
      log(clientSecret);

      emit(ClientSecretSuccess(clientSecret));
    });
  }
}
