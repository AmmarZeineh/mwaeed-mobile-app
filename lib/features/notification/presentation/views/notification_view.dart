import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/views/widgets/notification_view_body.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});
  static const routeName = 'notification-view';

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'notification.notifications'.tr(),
          style: AppTextStyles.w600_18.copyWith(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: NotificationViewBody()),
    );
  }
}
