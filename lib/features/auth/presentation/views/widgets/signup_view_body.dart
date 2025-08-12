import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? name, email, password, phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32),
              Image.asset(
                Assets.imagesLogo,
                height: MediaQuery.sizeOf(context).height / 4,
                width: MediaQuery.sizeOf(context).width / 2,
              ),
              SizedBox(height: 32),
              Text(
                tr('auth.create_account'),
                style: AppTextStyles.w600_20,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              CustomTextFormField(
                onSaved: (value) => name = value,
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                title: 'auth.name'.tr(),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                onSaved: (value) => email = value,
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                title: 'auth.email'.tr(),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                onSaved: (value) => phone = value,
                textInputType: TextInputType.phone,
                prefixIcon: Icons.phone,
                title: 'auth.phone'.tr(),
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) => password = value,
                textInputType: TextInputType.text,
                obscureText: true,
                prefixIcon: Icons.password,
                title: 'auth.password'.tr(),
              ),
              SizedBox(height: 24),
              CustomElevatedButton(
                title: tr('auth.signup'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SignupCubit>().signup(
                      email: email!,
                      password: password!,
                      name: name!,
                      phone: phone!,
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginView.routeName);
                },
                child: Text(
                  tr('auth.already_have_account'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w400_14.copyWith(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
