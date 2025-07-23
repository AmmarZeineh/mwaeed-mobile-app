import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignupViewBody()));
  }
}
