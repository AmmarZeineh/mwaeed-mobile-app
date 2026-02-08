import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/verify_cubit/verify_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/enter_code_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const String routeName = "forgot_password_view";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ForgotPasswordViewBody()));
  }
}

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit, VerifyState>(
      listener: (context, state) {
        if (state is EmailVerificationLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ResendVerificationSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showSuccessMessage(tr('auth.Code_resent'), context);

          Navigator.pushNamed(
            context,
            EnterCodeView.routeName,
            arguments: email,
          );
        }

        if (state is EmailVerificationError) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          showErrorMessage(state.message, context);
        }
      },
      builder: (context, state) {
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
                    "auth.forgot_password".tr(),
                    style: AppTextStyles.w700_20,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "auth.please_enter_your_email".tr(),
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
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    title: "common.ok".tr(),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (context.mounted) {
                          await context
                              .read<VerifyCubit>()
                              .resendVerificationEmail(email: email!);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
