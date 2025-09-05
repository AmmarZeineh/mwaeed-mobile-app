import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'profile.choose_the_lang'.tr(),
        style: AppTextStyles.w600_18.copyWith(color: AppColors.primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOption(languageCode: "ar", languageName: "العربية"),
          SizedBox(height: 8.h),
          _LanguageOption(languageCode: "en", languageName: "English"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'common.cancel'.tr(),
            style: AppTextStyles.w500_14.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String languageCode;
  final String languageName;

  const _LanguageOption({
    required this.languageCode,
    required this.languageName,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.locale.languageCode == languageCode;

    return GestureDetector(
      onTap: () {
        context.setLocale(Locale(languageCode));
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          languageName,
          style: AppTextStyles.w500_14.copyWith(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
