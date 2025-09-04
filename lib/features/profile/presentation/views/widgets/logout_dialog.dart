import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'logout'.tr(),
        style: AppTextStyles.w600_18.copyWith(color: AppColors.primaryColor),
      ),
      content: Text(
        'profile.are_you_sure_logout'.tr(),
        style: AppTextStyles.w400_14.copyWith(color: AppColors.primaryColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'close'.tr(),
            style: AppTextStyles.w500_14.copyWith(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () => _handleLogout(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
          child: Text(
            'logout'.tr(),
            style: AppTextStyles.w500_14.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
