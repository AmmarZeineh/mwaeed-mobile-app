import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class CustomSeeAllWidget extends StatelessWidget {
  const CustomSeeAllWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.w700_16),
        Spacer(),
        Text(
          'common.see_all'.tr(),
          style: AppTextStyles.w500_14.copyWith(color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
