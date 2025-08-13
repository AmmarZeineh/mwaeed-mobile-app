import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/verify_view.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
      case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
       case VerifyView.routeName:
        final String email =
          settings.arguments as String ;
      return MaterialPageRoute(builder: (_) =>  VerifyView(email: email,));
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
