import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';

class LookingForProviderContainer extends StatelessWidget {
  const LookingForProviderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Image.asset(Assets.imagesImage),
          Positioned(
            top: 30,
            left: 8,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                children: [
                  Text(
                    tr('home.looking_for_provider'),
                    style: AppTextStyles.w600_18.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    tr('home.scedule_appointment'),
                    style: AppTextStyles.w400_12.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
