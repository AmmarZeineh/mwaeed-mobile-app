import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/cubits/fetch_notification_cubit/fetch_notification_cubit.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/views/widgets/notification_widget.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNotificationCubit, FetchNotificationState>(
      builder: (context, state) {
        if (state is FetchNotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchNotificationFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is FetchNotificationSuccess) {
          if (state.notifications.isEmpty) {
            return Center(child: Text('No Notifications'.tr()));
          } else {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: NotificationWidget(
                        notification: state.notifications[index],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
