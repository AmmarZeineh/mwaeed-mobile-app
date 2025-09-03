import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.iconData,
    this.onTap,
    this.readOnly = false,
    this.heroTag,
    this.autofocus = false,
    this.onSubmitted,
  });
  final String title;
  final IconData iconData;
  final void Function()? onTap;
  final bool readOnly;
  final String? heroTag;
  final bool autofocus;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      onTap: onTap,
      readOnly: readOnly,
      autofocus: autofocus,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hint: Text(
          tr(title),
          style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
        ),
        prefixIcon: Icon(iconData, color: Colors.grey),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: Color(0xfff3f4f6),
        filled: true,
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: Material(color: Colors.transparent, child: textField),
      );
    }

    return textField;
  }
}
