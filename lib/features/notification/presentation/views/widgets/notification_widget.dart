import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/entities/notification_entity.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/cubits/fetch_notification_cubit/fetch_notification_cubit.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/cubits/mark_as_read_cubit/mark_as_read_cubit.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notification});
  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 100000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title ?? '', style: AppTextStyles.w600_14),
                  Text(notification.body ?? ''),
                ],
              ),
            ),
            Spacer(),
            notification.isRead == true
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await context.read<MarkAsReadCubit>().markAsRead(
                          context: context,
                          notificationId: notification.id!,
                        );
                        // ignore: use_build_context_synchronously
                        context
                            .read<FetchNotificationCubit>()
                            // ignore: use_build_context_synchronously
                            .fetchNotifications(context: context);
                      },
                      icon: Icon(Icons.check, color: Colors.green),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
