part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoaded &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'UserLoaded(user: $user)';
}

class UserLoading extends UserState {
  final UserEntity user;

  UserLoading(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoading &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'UserLoading(user: $user)';
}

class UserLoadingInitial extends UserState {
  @override
  String toString() => 'UserLoadingInitial()';
}

class UserError extends UserState {
  final String message;
  final UserEntity? user;

  UserError(this.message, [this.user]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          user == other.user;

  @override
  int get hashCode => message.hashCode ^ user.hashCode;

  @override
  String toString() => 'UserError(message: $message, user: $user)';
}

class UserErrorInitial extends UserState {
  final String message;

  UserErrorInitial(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserErrorInitial &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'UserErrorInitial(message: $message)';
}
