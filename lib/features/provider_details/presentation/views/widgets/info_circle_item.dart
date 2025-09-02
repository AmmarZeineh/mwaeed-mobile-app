
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class InfoCircleItem extends StatelessWidget {
  const InfoCircleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.star, color: AppColors.primaryColor, size: 30),
        ),
        SizedBox(height: 5),
        Text("4.5", style: AppTextStyles.w600_14.copyWith(color: Colors.black)),
      ],
    );
  }
}
