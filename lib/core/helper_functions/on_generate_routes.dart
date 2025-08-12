import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/home_view.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
