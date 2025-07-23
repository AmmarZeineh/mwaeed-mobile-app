import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static const routeName = 'onboarding-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: OnboardingViewBody()));
  }
}
