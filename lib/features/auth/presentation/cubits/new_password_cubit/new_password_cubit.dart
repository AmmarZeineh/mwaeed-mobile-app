import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.authRepo) : super(NewPasswordInitial());
  final AuthRepo authRepo;
  Future<void> newPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(NewPasswordLoading());
    final result = await authRepo.forgotPassword(
      email: email,
      newPassword: newPassword,
    );
    result.fold(
      (l) => emit(NewPasswordFailure(l.message)),
      (r) => emit(NewPasswordSuccess()),
    );
  }
}
