part of 'fetch_notification_cubit.dart';

@immutable
sealed class FetchNotificationState {}

final class FetchNotificationInitial extends FetchNotificationState {}

final class FetchNotificationLoading extends FetchNotificationState {}

final class FetchNotificationSuccess extends FetchNotificationState {
  final List<NotificationEntity> notifications;
  final bool hasUnreadNotifications;

  FetchNotificationSuccess(
    this.notifications, {
    required this.hasUnreadNotifications,
  });
}

final class FetchNotificationFailure extends FetchNotificationState {
  final String errMessage;

  FetchNotificationFailure(this.errMessage);
}
