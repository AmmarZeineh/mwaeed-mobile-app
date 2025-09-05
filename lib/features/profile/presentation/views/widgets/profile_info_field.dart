import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class ProfileInfoField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController? controller;
  final String? value;
  final bool isEditing;
  final VoidCallback? onEditToggle;
  final bool canEdit;

  const ProfileInfoField({
    super.key,
    required this.icon,
    required this.label,
    this.controller,
    this.value,
    this.isEditing = false,
    this.onEditToggle,
    this.canEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.w400_12.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 4.h),
                if (isEditing && controller != null) ...[
                  TextFormField(
                    controller: controller,
                    style: AppTextStyles.w500_14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  Text(
                    value ?? controller?.text ?? '',
                    style: AppTextStyles.w500_14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (canEdit) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onEditToggle,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: isEditing
                      ? Colors.green.withValues(alpha: 0.1)
                      : AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  isEditing ? Icons.check : Icons.edit_outlined,
                  color: isEditing ? Colors.green : AppColors.primaryColor,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
