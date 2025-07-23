import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.onSaved,
    required this.textInputType,
    required this.prefixIcon,
    required this.title,
  });
  final bool obscureText;
  final TextInputType textInputType;
  final void Function(String?)? onSaved;
  final IconData prefixIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return tr('common.required_field');
        }
        return null;
      },
      keyboardType: textInputType,

      decoration: InputDecoration(
        hint: Text(
          title,
          style: AppTextStyles.w400_14.copyWith(color: Colors.grey.shade400),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.grey.shade400),
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.8),
    );
  }
}
