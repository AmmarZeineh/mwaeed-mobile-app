import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/home_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/verify_view.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/views/search_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case VerifyView.routeName:
      final String email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => VerifyView(email: email));
    case SearchView.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
