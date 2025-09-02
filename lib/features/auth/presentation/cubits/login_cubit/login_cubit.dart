import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
    required String fcmToken,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.login(
      email: email,
      password: password,
      context: context,
      fcmToken: fcmToken,
    );
    result.fold(
      (l) => emit(LoginFailure(l.message)),
      (r) => emit(LoginSuccess()),
    );
  }
}
