import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/card_divider.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/change_password_dialog.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/language_dialog.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_setting_item.dart';

class ProfileSettingsCard extends StatelessWidget {
  const ProfileSettingsCard({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const LanguageDialog());
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ChangePasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileSettingItem(
            icon: Icons.language_outlined,
            title: 'common.language'.tr(),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                context.locale.languageCode == 'ar' ? "العربية" : "English",
                style: AppTextStyles.w500_12.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            onTap: () => _showLanguageDialog(context),
          ),
          const CardDivider(),
          ProfileSettingItem(
            icon: Icons.lock_outline,
            title: 'auth.change_password'.tr(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16.sp,
            ),
            onTap: () => _showChangePasswordDialog(context),
          ),
        ],
      ),
    );
  }
}
