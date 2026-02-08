import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
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

  bool _isEditingName = false;
  bool _isEditingPhone = false;
  bool _isEditingCity = false;
  List<CityEntity> cities = [];
  late String selectedCity;

  @override
  void initState() {
    super.initState();
    userEntity = context.read<UserCubit>().currentUser!;
    selectedCity = userEntity.city;
    _nameController = TextEditingController(text: userEntity.name);
    _phoneController = TextEditingController(text: userEntity.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String _getCityCode(String formattedName) {
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

  void _updateUserData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedUser = UserEntity(
      id: userEntity.id,
      name: _nameController.text.trim(),
      email: userEntity.email,
      phoneNumber: _phoneController.text.trim(),
      city: userEntity.city,
      accessToken: userEntity.accessToken,
    );
    await context.read<ProfileCubit>().updateUserData(
      body: {
        "phoneNumber": updatedUser.phoneNumber,
        "name": updatedUser.name,
        "city": _getCityCode(selectedCity),
      },
      userId: context.read<UserCubit>().currentUser!.id,
    );

    await Prefs.setString(userKey, jsonEncode(updatedUser));
    // ignore: use_build_context_synchronously
    context.read<UserCubit>().updateUser(updatedUser);

    setState(() {
      _isEditingName = false;
      _isEditingPhone = false;
      _isEditingCity = false;
    });
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
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          showSuccessMessage('common.success'.tr(), context);
        } else if (state is ProfileFailure) {
          showErrorMessage(state.errMessage, context);
        }
        if (state is ProfileCitiesLoaded) {
          for (var i = 0; i < state.cities.length; i++) {
            cities.add(state.cities[i]);
          }
        }
      },
      builder: (context, profileState) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
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
                      isEditingName: _isEditingName,
                      isEditingPhone: _isEditingPhone,
                      isEditingCity: _isEditingCity,
                      formKey: _formKey,
                      onUpdateUser: _updateUserData,
                      onToggleEditing: _toggleEditingState,
                      cities: cities,
                      onChanged: (value) {
                        selectedCity = value;
                      },
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
      },
    );
  }
}
