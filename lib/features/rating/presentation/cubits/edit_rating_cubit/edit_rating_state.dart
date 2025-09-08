part of 'edit_rating_cubit.dart';

@immutable
sealed class EditRatingState {}

final class EditRatingInitial extends EditRatingState {}

final class EditRatingLoading extends EditRatingState {}

final class EditRatingFailure extends EditRatingState {
  final String errMessage;

  EditRatingFailure(this.errMessage);
}

final class EditRatingSuccess extends EditRatingState {}
