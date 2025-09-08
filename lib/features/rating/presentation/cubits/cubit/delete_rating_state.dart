part of 'delete_rating_cubit.dart';

@immutable
sealed class DeleteRatingState {}

final class DeleteRatingInitial extends DeleteRatingState {}

final class DeleteRatingLoading extends DeleteRatingState {}

final class DeleteRatingSuccess extends DeleteRatingState {}

final class DeleteRatingFailure extends DeleteRatingState {
  final String errMessage;

  DeleteRatingFailure(this.errMessage);
}
