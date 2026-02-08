import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  void _handleLogout(BuildContext context) {
    context.read<ProfileCubit>().logout();
    Prefs.remove(userKey);
    Navigator.pushNamedAndRemoveUntil(
      context,
      OnboardingView.routeName,
      (route) => false,
    );
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
