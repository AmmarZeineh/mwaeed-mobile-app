import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/utils/app_images.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/verify_cubit/verify_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/new_password_view.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key, required this.email});
  static const String routeName = 'enter-code-view';
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: EnterCodeVeiwBody(email: email)),
    );
  }
}

class EnterCodeVeiwBody extends StatefulWidget {
  const EnterCodeVeiwBody({super.key, required this.email});
  final String email;

  @override
  State<EnterCodeVeiwBody> createState() => _EnterCodeVeiwBodyState();
}

class _EnterCodeVeiwBodyState extends State<EnterCodeVeiwBody> {
  String? code;
  Timer? _timer;
  int _resendCountdown = 0;
  bool _canResend = true;

  static const int _resendDelaySeconds = 120;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = _resendDelaySeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
        } else {
          Navigator.of(context, rootNavigator: true).pop(); // إغلاق اللودينغ
        }

        if (state is EmailVerificationSuccess) {
          showSuccessMessage(tr('auth.Verification_success'), context);
          Navigator.pushNamed(
            context,
            NewPasswordView.routeName,
            arguments: widget.email,
          );
        } else if (state is EmailVerificationError) {
          showErrorMessage(state.message, context);
        } else if (state is ResendVerificationSuccess) {
          showSuccessMessage(tr('auth.code_sent'), context);
          _startResendTimer();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  Assets.imagesLogo,
                  height: MediaQuery.sizeOf(context).height / 4,
                  width: MediaQuery.sizeOf(context).width / 2,
                ),
                const SizedBox(height: 32),
                Text(
                  tr('auth.Verify_code'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w600_20,
                ),
                const SizedBox(height: 32),
                VerificationCodeField(
                  length: 6,
                  onFilled: (value) {
                    code = value;
                  },
                  size: const Size(30, 60),
                  spaceBetween: 16,
                  matchingPattern: RegExp(r'^\d+$'),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      if (code != null && code!.length == 6) {
                        await context.read<VerifyCubit>().verifyEmail(
                          email: widget.email,
                          verificationCode: code!,
                        );
                      } else {
                        showErrorMessage(tr('auth.Enter_valid_code'), context);
                      }
                    },
                    title: 'auth.Verify'.tr(),
                  ),
                ),

                if (_canResend)
                  TextButton(
                    onPressed: () {
                      context.read<VerifyCubit>().resendVerificationEmail(
                        email: widget.email,
                      );
                    },
                    child: Text(
                      tr('auth.Resend_code'),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Text(
                          tr('auth.Resend_available_in'),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatTime(_resendCountdown),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text(
                            tr('auth.Resend_code'),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
