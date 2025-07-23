import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_form_field.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
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
              textInputType: TextInputType.text,
              prefixIcon: Icons.person,
              title: 'auth.name'.tr(),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              title: 'auth.email'.tr(),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              textInputType: TextInputType.phone,
              prefixIcon: Icons.phone,
              title: 'auth.phone'.tr(),
            ),
            SizedBox(height: 24),
            CustomTextFormField(
              textInputType: TextInputType.text,
              obscureText: true,
              prefixIcon: Icons.password,
              title: 'auth.password'.tr(),
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              title: tr('auth.signup'),
              onPressed: () {
                context.setLocale(Locale('en'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
