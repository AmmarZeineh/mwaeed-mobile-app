import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/logout_dialog.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const LogoutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () => _showLogoutDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: AppColors.secondaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'auth.logout'.tr(),
                  style: AppTextStyles.w600_16.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
