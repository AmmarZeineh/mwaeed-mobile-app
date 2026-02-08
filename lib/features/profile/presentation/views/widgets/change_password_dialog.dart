import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_passwordFormKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordCubit>().changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmNewPassword: _confirmPasswordController.text,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }

        if (state is ChangePasswordSuccess) {
          Navigator.pop(context); // إغلاق الديالوج
          showSuccessMessage(
            tr("profile.password_changed_successfully"),
            context,
          );
        } else if (state is ChangePasswordFailure) {
          showErrorMessage(state.errMessage, context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            'auth.change_password'.tr(),
            style: AppTextStyles.w600_18.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          content: Form(
            key: _passwordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PasswordField(
                  controller: _currentPasswordController,
                  labelText: 'profile.current_password'.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'profile.current_password_is_required'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _PasswordField(
                  controller: _newPasswordController,
                  labelText: 'profile.new_password'.tr(),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'profile.password_must_be_at_least_six_letters'
                          .tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _PasswordField(
                  controller: _confirmPasswordController,
                  labelText: 'profile.confirm_new_password'.tr(),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'profile.unmatched_password'.tr();
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "common.cancel".tr(),
                style: AppTextStyles.w500_14.copyWith(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: state is ChangePasswordLoading ? null : _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                "common.save".tr(),
                style: AppTextStyles.w500_14.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const _PasswordField({
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      validator: validator,
    );
  }
}
