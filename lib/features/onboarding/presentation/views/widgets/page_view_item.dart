import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.pageController,
    required this.image,
  });
  final String title, subTitle;
  final PageController pageController;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        SizedBox(height: 28),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
          child: Column(
            children: [
              Text(tr(title), style: AppTextStyles.w700_18),
              SizedBox(height: 8),
              Text(
                tr(subTitle),
                style: AppTextStyles.w400_14,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  title: tr('common.next'),
                  onPressed: () {
                    if (pageController.page!.round() >= 2) {
                      Navigator.pushNamed(context, SignupView.routeName);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
