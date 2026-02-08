import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/entities/notification_entity.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/repos/notification_repo.dart';

part 'fetch_notification_state.dart';

class FetchNotificationCubit extends Cubit<FetchNotificationState> {
  FetchNotificationCubit(this._notificationRepo)
    : super(FetchNotificationInitial());

  final NotificationRepo _notificationRepo;

  bool get hasRedDot {
    final currentState = state;
    if (currentState is FetchNotificationSuccess) {
      return currentState.hasUnreadNotifications;
    }
    return false;
  }

  Future<void> fetchNotifications({required context}) async {
    emit(FetchNotificationLoading());
    final result = await _notificationRepo.getNotifications(context: context);
    result.fold((failure) => emit(FetchNotificationFailure(failure.message)), (
      notifications,
    ) {
      // التحقق من وجود notifications غير مقروءة
      bool hasUnread = notifications.any(
        (notification) => !notification.isRead!,
      );
      emit(
        FetchNotificationSuccess(
          notifications,
          hasUnreadNotifications: hasUnread,
        ),
      );
    });
  }
}
