

import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:readmore/readmore.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: AppTextStyles.w400_16.copyWith(color: Colors.black54),
      "slkh slh lsk hoiw ls ogjijs lkk n nllksohi n slinlg oinl ngnwo lspqr ei ns ngwin ",
      trimLines: 3,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'قراءة المزيد',
      trimExpandedText: 'إظهار أقل',
      moreStyle: AppTextStyles.w400_12.copyWith(color: Colors.black),

      lessStyle: AppTextStyles.w400_12.copyWith(color: Colors.black54),
      textAlign: TextAlign.start,
    );
  }
}
