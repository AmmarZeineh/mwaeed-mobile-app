import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';

class CityDropdownField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final List<String> cities;
  final Function(String?) onChanged;
  final bool isEditing;
  final VoidCallback? onEditToggle;
  final bool canEdit;

  const CityDropdownField({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    required this.cities,
    required this.onChanged,
    this.isEditing = false,
    this.onEditToggle,
    this.canEdit = false,
  });

  String _formatCityName(String cityCode) {
    // تحويل الرموز إلى أسماء منسقة
    switch (cityCode.toUpperCase()) {
      case 'DAMASCUS':
        return 'Damascus';
      case 'ALEPPO':
        return 'Aleppo';
      case 'HOMS':
        return 'Homs';
      case 'HAMA':
        return 'Hama';
      case 'LATTAKIA':
        return 'Lattakia';
      case 'TARTOUS':
        return 'Tartous';
      case 'DARAA':
        return 'Daraa';
      case 'SWEIDA':
        return 'Sweida';
      case 'QUNEITRA':
        return 'Quneitra';
      case 'DEIR_EZZOR':
        return 'Deir Ezzor';
      case 'RAQQA':
        return 'Raqqa';
      case 'HASAKA':
        return 'Hasaka';
      case 'IDLIB':
        return 'Idlib';
      case 'DAMASCUS_COUNTRYSIDE':
        return 'Damascus Countryside';
      default:
        // تنسيق عام: إزالة الشرطات السفلية وجعل أول حرف كبير
        return cityCode
            .toLowerCase()
            .replaceAll('_', ' ')
            .split(' ')
            .map(
              (word) => word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1)}'
                  : word,
            )
            .join(' ');
    }
  }

  String _getCityCode(String formattedName) {
    // تحويل الأسماء المنسقة إلى رموز
    switch (formattedName) {
      case 'Damascus':
        return 'DAMASCUS';
      case 'Aleppo':
        return 'ALEPPO';
      case 'Homs':
        return 'HOMS';
      case 'Hama':
        return 'HAMA';
      case 'Lattakia':
        return 'LATTAKIA';
      case 'Tartous':
        return 'TARTOUS';
      case 'Daraa':
        return 'DARAA';
      case 'Sweida':
        return 'SWEIDA';
      case 'Quneitra':
        return 'QUNEITRA';
      case 'Deir Ezzor':
        return 'DEIR_EZZOR';
      case 'Raqqa':
        return 'RAQQA';
      case 'Hasaka':
        return 'HASAKA';
      case 'Idlib':
        return 'IDLIB';
      case 'Damascus Countryside':
        return 'DAMASCUS_COUNTRYSIDE';
      default:
        return formattedName.toUpperCase().replaceAll(' ', '_');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: AppColors.primaryColor),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              if (isEditing) ...[
                DropdownButtonFormField<String>(
                  value: value != null ? _formatCityName(value!) : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    isDense: true,
                  ),
                  items: cities.map((city) {
                    final formattedCity = _formatCityName(city);
                    return DropdownMenuItem<String>(
                      value: formattedCity,
                      child: Text(
                        formattedCity,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedCity) {
                    if (selectedCity != null) {
                      final cityCode = _getCityCode(selectedCity);
                      onChanged(cityCode);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'profile.city_required'.tr();
                    }
                    return null;
                  },
                ),
              ] else ...[
                Text(
                  value != null ? _formatCityName(value!) : '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
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
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isEditing ? AppColors.primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                isEditing ? Icons.check : Icons.edit,
                size: 16.w,
                color: isEditing ? AppColors.secondaryColor : Colors.grey[600],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
