import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/repos/notification_repo.dart';

part 'mark_as_read_state.dart';

class MarkAsReadCubit extends Cubit<MarkAsReadState> {
  MarkAsReadCubit(this._notificationRepo) : super(MarkAsReadInitial());

  final NotificationRepo _notificationRepo;

  Future<void> markAsRead({
    required BuildContext context,
    required int notificationId,
  }) async {
    emit(MarkAsReadLoading());
    var result = await _notificationRepo.markAsRead(
      context: context,
      notificationId: notificationId,
    );
    result.fold(
      (failure) => emit(MarkAsReadFailure(failure.message)),
      (_) => emit(MarkAsReadSuccess()),
    );
  }
}
