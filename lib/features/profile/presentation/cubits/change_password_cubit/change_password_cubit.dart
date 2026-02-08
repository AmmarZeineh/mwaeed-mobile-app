import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.profileRepo) : super(ChangePasswordInitial());
  final ProfileRepo profileRepo;
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
    required BuildContext context,
  }) async {
    emit(ChangePasswordLoading());
    final result = await profileRepo.changePassword(
      oldPassword: currentPassword,
      newPassword: newPassword,
      context: context,
    );
    result.fold(
      (l) => emit(ChangePasswordFailure(l.message)),
      (r) => emit(ChangePasswordSuccess()),
    );
  }
}
