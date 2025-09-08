import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/notification_service.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/signup_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Image.asset(
                Assets.imagesLogo,
                height: MediaQuery.sizeOf(context).height / 4,
                width: MediaQuery.sizeOf(context).width / 2,
              ),
              const SizedBox(height: 32),
              Text(
                "auth.hi_welcome_back".tr(),
                style: AppTextStyles.w700_20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "auth.hope_your_fine".tr(),
                style: AppTextStyles.w400_14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomTextFormField(
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                title: "auth.email".tr(),
                onSaved: (p0) => email = p0,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                textInputType: TextInputType.text,
                obscureText: true,
                prefixIcon: Icons.password,
                title: "auth.password".tr(),
                onSaved: (p0) => password = p0,
              ),
              SizedBox(height: 23),
              CustomElevatedButton(
                title: "auth.login".tr(),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var token = await NotificationService.getFcmToken();
                    formKey.currentState!.save();
                    if (context.mounted) {
                      context.read<LoginCubit>().login(
                        email: email!,
                        password: password!,
                        context: context,
                        fcmToken: token!,
                      );
                    }
                    log(token.toString());
                  }
                },
              ),
              SizedBox(height: 15),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "auth.dont_have_an_account".tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "auth.signup".tr(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, SignupView.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPasswordView.routeName);
                },
                child: Text(
                  "auth.forgot_password".tr(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
