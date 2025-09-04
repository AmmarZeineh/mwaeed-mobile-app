import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_action_buttons.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_image_widget.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_info_card.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_settings_card.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/section_title_widget.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late UserEntity userEntity;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;

  bool _isEditingName = false;
  bool _isEditingPhone = false;
  bool _isEditingCity = false;

  @override
  void initState() {
    super.initState();
    userEntity = context.read<UserCubit>().currentUser!;
    _nameController = TextEditingController(text: userEntity.name);
    _phoneController = TextEditingController(text: userEntity.phoneNumber);
    _cityController = TextEditingController(text: userEntity.city);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _updateUserData() {
    final updatedUser = UserEntity(
      id: userEntity.id,
      name: _nameController.text.trim(),
      email: userEntity.email,
      phoneNumber: _phoneController.text.trim(),
      city: _cityController.text.trim(),
      accessToken: userEntity.accessToken,
    );
    Prefs.setString(userKey, jsonEncode(updatedUser));
    context.read<UserCubit>().updateUser(updatedUser);
  }

  void _toggleEditingState({bool? name, bool? phone, bool? city}) {
    setState(() {
      if (name != null) _isEditingName = name;
      if (phone != null) _isEditingPhone = phone;
      if (city != null) _isEditingCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (context.read<UserCubit>().currentUser != null) {
          userEntity = context.read<UserCubit>().currentUser!;
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                const ProfileImageWidget(),
                SizedBox(height: 32.h),
                SectionTitleWidget(title: 'profile.personal_info'.tr()),
                SizedBox(height: 16.h),
                ProfileInfoCard(
                  userEntity: userEntity,
                  nameController: _nameController,
                  phoneController: _phoneController,
                  cityController: _cityController,
                  isEditingName: _isEditingName,
                  isEditingPhone: _isEditingPhone,
                  isEditingCity: _isEditingCity,
                  formKey: _formKey,
                  onUpdateUser: _updateUserData,
                  onToggleEditing: _toggleEditingState,
                ),
                SizedBox(height: 32.h),
                SectionTitleWidget(title: 'profile.settings'.tr()),
                SizedBox(height: 16.h),
                const ProfileSettingsCard(),
                SizedBox(height: 32.h),
                const ProfileActionButtons(),
              ],
            ),
          ),
        );
      },
    );
  }
}
