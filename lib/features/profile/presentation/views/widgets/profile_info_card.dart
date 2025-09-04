import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/card_divider.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_info_field.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserEntity userEntity;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final bool isEditingName;
  final bool isEditingPhone;
  final bool isEditingCity;
  final GlobalKey<FormState> formKey;
  final VoidCallback onUpdateUser;
  final Function({bool? name, bool? phone, bool? city}) onToggleEditing;

  const ProfileInfoCard({
    super.key,
    required this.userEntity,
    required this.nameController,
    required this.phoneController,
    required this.cityController,
    required this.isEditingName,
    required this.isEditingPhone,
    required this.isEditingCity,
    required this.formKey,
    required this.onUpdateUser,
    required this.onToggleEditing,
  });

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
          ProfileInfoField(
            icon: Icons.person_outline,
            label: 'profile.name'.tr(),
            controller: nameController,
            isEditing: isEditingName,
            onEditToggle: () {
              if (isEditingName) {
                if (formKey.currentState?.validate() ?? false) {
                  onUpdateUser();
                  onToggleEditing(name: false);
                }
              } else {
                onToggleEditing(name: true);
              }
            },
            canEdit: true,
          ),
          const CardDivider(),
          ProfileInfoField(
            icon: Icons.email_outlined,
            label: 'profile.email'.tr(),
            value: userEntity.email,
            canEdit: false,
          ),
          const CardDivider(),
          ProfileInfoField(
            icon: Icons.phone_outlined,
            label: 'profile.phone'.tr(),
            controller: phoneController,
            isEditing: isEditingPhone,
            onEditToggle: () {
              if (isEditingPhone) {
                if (formKey.currentState?.validate() ?? false) {
                  onUpdateUser();
                  onToggleEditing(phone: false);
                }
              } else {
                onToggleEditing(phone: true);
              }
            },
            canEdit: true,
          ),
          const CardDivider(),
          ProfileInfoField(
            icon: Icons.location_city_outlined,
            label: 'profile.city'.tr(),
            controller: cityController,
            isEditing: isEditingCity,
            onEditToggle: () {
              if (isEditingCity) {
                if (formKey.currentState?.validate() ?? false) {
                  onUpdateUser();
                  onToggleEditing(city: false);
                }
              } else {
                onToggleEditing(city: true);
              }
            },
            canEdit: true,
          ),
        ],
      ),
    );
  }
}
