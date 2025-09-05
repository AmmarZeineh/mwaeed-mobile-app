import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/card_divider.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/city_drop_down_field.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_info_field.dart';

class ProfileInfoCard extends StatefulWidget {
  final UserEntity userEntity;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool isEditingName;
  final bool isEditingPhone;
  final bool isEditingCity;
  final GlobalKey<FormState> formKey;
  final VoidCallback onUpdateUser;
  final ValueChanged<String> onChanged;
  final Function({bool? name, bool? phone, bool? city}) onToggleEditing;
  final List<String> cities; // قائمة المحافظات من الـ API

  const ProfileInfoCard({
    super.key,
    required this.userEntity,
    required this.nameController,
    required this.phoneController,
    required this.isEditingName,
    required this.isEditingPhone,
    required this.isEditingCity,
    required this.formKey,
    required this.onUpdateUser,
    required this.onToggleEditing,
    required this.cities,
    required this.onChanged,
  });

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.userEntity.city;
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
          ProfileInfoField(
            icon: Icons.person_outline,
            label: 'profile.name'.tr(),
            controller: widget.nameController,
            isEditing: widget.isEditingName,
            onEditToggle: () {
              if (widget.isEditingName) {
                if (widget.formKey.currentState?.validate() ?? false) {
                  widget.onUpdateUser();
                }
              } else {
                widget.onToggleEditing(name: true);
              }
            },
            canEdit: true,
          ),
          const CardDivider(),
          ProfileInfoField(
            icon: Icons.email_outlined,
            label: 'profile.email'.tr(),
            value: widget.userEntity.email,
            canEdit: false,
          ),
          const CardDivider(),
          ProfileInfoField(
            icon: Icons.phone_outlined,
            label: 'profile.phone'.tr(),
            controller: widget.phoneController,
            isEditing: widget.isEditingPhone,
            onEditToggle: () {
              if (widget.isEditingPhone) {
                if (widget.formKey.currentState?.validate() ?? false) {
                  widget.onUpdateUser();
                }
              } else {
                widget.onToggleEditing(phone: true);
              }
            },
            canEdit: true,
          ),
          const CardDivider(),
          SizedBox(height: 8),
          CityDropdownField(
            icon: Icons.location_city_outlined,
            label: 'profile.city'.tr(),
            value: selectedCity,
            cities: widget.cities,
            isEditing: widget.isEditingCity,
            onChanged: (city) {
              setState(() {
                selectedCity = city;
                widget.onChanged(city!);
              });
            },
            onEditToggle: () {
              if (widget.isEditingCity) {
                if (widget.formKey.currentState?.validate() ?? false) {
                  widget.onUpdateUser();
                }
              } else {
                widget.onToggleEditing(city: true);
              }
            },
            canEdit: true,
          ),
        ],
      ),
    );
  }
}
