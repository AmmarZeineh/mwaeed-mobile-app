part of 'verify_cubit.dart';

@immutable
sealed class VerifyState {}

class EmailVerificationInitial extends VerifyState {}

class EmailVerificationLoading extends VerifyState {}

class EmailVerificationSuccess extends VerifyState {}

class ResendVerificationSuccess extends VerifyState {}

class EmailVerificationError extends VerifyState {
  final String message;

  EmailVerificationError(this.message);
}
