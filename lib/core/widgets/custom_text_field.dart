import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.iconData,
  });
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return TextField(
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
  }
}
