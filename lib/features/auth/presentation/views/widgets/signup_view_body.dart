import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
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
  String? name, email, password, phone, city;

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
              SizedBox(height: 20),
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
              // CitiesDropdown(
              //   onCitySelected: (value) {
              //     log(value.toString());
              //     city = value;
              //   },
              // ),
              // SizedBox(height: 24),
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
                      // city: city!,
                    );
                  }
                },
              ),

              SizedBox(height: 15),

              Center(
                child: RichText(
                  text: TextSpan(
                    text: "auth.do_you_have_an_account".tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "auth.login".tr(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, LoginView.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // }

  // class CitiesDropdown extends StatefulWidget {
  //   final Function(String?) onCitySelected;

  //   const CitiesDropdown({super.key, required this.onCitySelected});

  //   @override
  //   State<CitiesDropdown> createState() => _CitiesDropdownState();
  // }

  // class _CitiesDropdownState extends State<CitiesDropdown> {
  //   final List<String> cities = [
  //     'دمشق',
  //     'حلب',
  //     'حمص',
  //     'اللاذقية',
  //     'طرطوس',
  //     'حماة',
  //   ];

  //   String? selectedCity;

  //   @override
  //   Widget build(BuildContext context) {
  //     return Center(
  //       child: DropdownButton2<String>(
  //         isExpanded: true,
  //         hint: const Text(
  //           'select city',
  //           style: TextStyle(fontSize: 16, color: Colors.grey),
  //         ),
  //         items: cities
  //             .map(
  //               (city) => DropdownMenuItem<String>(
  //                 value: city,
  //                 child: Text(city, style: const TextStyle(fontSize: 16)),
  //               ),
  //             )
  //             .toList(),
  //         value: selectedCity,
  //         onChanged: (value) {
  //           setState(() {
  //             selectedCity = value;
  //           });
  //           widget.onCitySelected(value);
  //         },
  //         buttonStyleData: const ButtonStyleData(
  //           decoration: BoxDecoration(shape: BoxShape.rectangle),
  //           padding: EdgeInsets.symmetric(horizontal: 16),
  //           height: 50,
  //           width: 300,
  //         ),
  //         dropdownStyleData: const DropdownStyleData(maxHeight: 200),
  //         menuItemStyleData: const MenuItemStyleData(height: 40),
  //       ),
  //     );
  //   }
}
