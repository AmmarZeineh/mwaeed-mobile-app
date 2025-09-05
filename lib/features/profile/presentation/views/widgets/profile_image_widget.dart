import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            width: 2.w,
          ),
        ),
        child: Icon(Icons.person, size: 60.sp, color: AppColors.primaryColor),
      ),
    );
  }
}
