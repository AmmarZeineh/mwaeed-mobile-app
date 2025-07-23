import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SignupLoading());
    final result = await authRepo.signup(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
    result.fold(
      (l) => emit(SignupFailure(l.message)),
      (r) => emit(SignupSuccess()),
    );
  }
}
