import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final AuthRepo authRepo;

  VerifyCubit(this.authRepo) : super(EmailVerificationInitial());
  Future<void> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    emit(EmailVerificationLoading());
    final result = await authRepo.verifyEmail(
      email: email,
      verificationCode: verificationCode,
    );
    result.fold(
      (l) => emit(EmailVerificationError(l.message)),
      (r) => emit(EmailVerificationSuccess()),
    );
  }

  Future<void> resendVerificationEmail({required String email}) async {
    emit(EmailVerificationLoading());
    final result = await authRepo.resendVerificationEmail(email: email);
    result.fold(
      (l) => emit(EmailVerificationError(l.message)),
      (r) => emit(ResendVerificationSuccess()),
    );
  }
}
