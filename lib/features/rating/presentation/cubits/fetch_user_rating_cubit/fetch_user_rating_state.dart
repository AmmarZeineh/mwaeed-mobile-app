part of 'fetch_user_rating_cubit.dart';

@immutable
sealed class FetchUserRatingState {}

final class FetchUserRatingInitial extends FetchUserRatingState {}

final class FetchUserRatingLoading extends FetchUserRatingState {}

final class FetchUserRatingFailure extends FetchUserRatingState {
  final String errMessage;

  FetchUserRatingFailure(this.errMessage);
}

final class FetchUserRatingSuccess extends FetchUserRatingState {
  final RatingEntity? ratingEntity;

  FetchUserRatingSuccess(this.ratingEntity);
}
