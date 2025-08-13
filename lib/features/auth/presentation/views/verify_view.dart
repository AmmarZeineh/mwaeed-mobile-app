import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/cubits/verify_cubit/verify_cubit.dart';
import 'package:mwaeed_mobile_app/features/auth/presentation/views/widgets/verify_view_body.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key, required this.email});
  final String email;
  static const String routeName = "verify_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => VerifyCubit(getIt.get<AuthRepo>()),
          child: VerifyViewBody(email: email),
        ),
      ),
    );
  }
}
