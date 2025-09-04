import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.w600_18.copyWith(color: AppColors.primaryColor),
    );
  }
}
