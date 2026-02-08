part of 'client_secret_cubit.dart';

@immutable
sealed class ClientSecretState {}

final class ClientSecretInitial extends ClientSecretState {}

final class ClientSecretLoading extends ClientSecretState {}

final class ClientSecretFailure extends ClientSecretState {
  final String message;
  ClientSecretFailure(this.message);
}

final class ClientSecretSuccess extends ClientSecretState {
  final String clientSecret;
  ClientSecretSuccess(this.clientSecret);
}
