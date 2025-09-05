import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/widgets/main_layout_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/home_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/verify_view.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/appointments_view.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/profile_view.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/book_appoinment_view.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/provider_details.dart';
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
    case ProviderDetailsView.routeName:
      final provider = settings.arguments as ProviderEntity;

      return MaterialPageRoute(
        builder: (_) => ProviderDetailsView(provider: provider),
      );
    case BookAppointmentView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final provider = args['provider'] as ProviderEntity;
      final job = args['job'];
      final services = args['services'] as List<ServiceEntity>;

      return MaterialPageRoute(
        builder: (_) => BookAppointmentView(
          providerEntity: provider,
          job: job,
          services: services,
        ),
      );

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
    case MainLayoutView.routeName:
      return MaterialPageRoute(builder: (_) => MainLayoutView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (_) => ProfileView());
    case AppointmentsView.routeName:
      return MaterialPageRoute(builder: (_) => AppointmentsView());

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
