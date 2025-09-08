import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/new_password_cubit/new_password_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/login_view.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key, required this.email});
  static const String routeName = "new_password_view";
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NewPasswordCubit(getIt.get<AuthRepo>()),
        child: SafeArea(child: NewPasswordViewBody(email: email)),
      ),
    );
  }
}

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key, required this.email});
  final String email;

  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // هاد لازم يجيك من الشاشة السابقة (argument)
  String? newPassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // ✅ رجعنا الـ widget
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
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
                "auth.please_enter_your_new_password".tr(),
                style: AppTextStyles.w400_14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // إدخال كلمة المرور الجديدة
              CustomTextFormField(
                textInputType: TextInputType.visiblePassword,
                prefixIcon: Icons.password,
                title: "auth.password".tr(),
                obscureText: true,

                onSaved: (value) => newPassword = value,
              ),

              const SizedBox(height: 20),

              BlocConsumer<NewPasswordCubit, NewPasswordState>(
                listener: (context, state) {
                  if (state is NewPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم تغيير كلمة المرور بنجاح"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginView.routeName,
                      (route) => false,
                    );
                  } else if (state is NewPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    title: state is NewPasswordLoading
                        ? "جاري الحفظ..."
                        : "common.ok".tr(),
                    onPressed: state is NewPasswordLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              if (widget.email.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("لا يوجد بريد إلكتروني صالح"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // نفذ الاستدعاء بشكل async بدون ما تخلي onPressed async
                              Future.microtask(() async {
                                await context
                                    .read<NewPasswordCubit>()
                                    .newPassword(
                                      email: widget.email,
                                      newPassword: newPassword!,
                                    );
                              });
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
