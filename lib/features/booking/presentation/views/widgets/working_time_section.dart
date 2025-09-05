import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class WorkingTimeSection extends StatelessWidget {
  const WorkingTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Working time :", style: AppTextStyles.w700_16),
          SizedBox(height: 10),
          Text(
            "sunday to monday from nine to 10 pm",
            style: AppTextStyles.w400_16.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
