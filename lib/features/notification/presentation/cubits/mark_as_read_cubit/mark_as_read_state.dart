part of 'mark_as_read_cubit.dart';

@immutable
sealed class MarkAsReadState {}

final class MarkAsReadInitial extends MarkAsReadState {}

final class MarkAsReadLoading extends MarkAsReadState {}

final class MarkAsReadSuccess extends MarkAsReadState {}

final class MarkAsReadFailure extends MarkAsReadState {
  final String errorMessage;
  MarkAsReadFailure(this.errorMessage);
}
