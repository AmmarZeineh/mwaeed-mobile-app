import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/widgets/page_view_item.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController pageController;
  static const titels = [
    'onboarding.screen1.title',
    'onboarding.screen2.title',
    'onboarding.screen3.title',
  ];
  static const subTitels = [
    'onboarding.screen1.subtitle',
    'onboarding.screen2.subtitle',
    'onboarding.screen3.subtitle',
  ];
  static const images = [
    Assets.imagesOnboarding1,
    Assets.imagesOnboarding2,
    Assets.imagesOnboarding3,
  ];
  int currentIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentIndex = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 18,
          child: PageView.builder(
            onPageChanged: (value) {
              currentIndex = value;
              setState(() {});
            },
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return PageViewItem(
                image: images[index],
                pageController: pageController,
                title: titels[index],
                subTitle: subTitels[index],
              );
            },
          ),
        ),
        DotsIndicator(
          animate: true,
          dotsCount: 3,
          position: currentIndex.toDouble(),
          decorator: DotsDecorator(
            activeSize: const Size(24.0, 8.0),
            activeColor: AppColors.primaryColor,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        SizedBox(height: 24),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SignupView.routeName);
            },
            child: Text(
              tr('common.skip'),
              style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
