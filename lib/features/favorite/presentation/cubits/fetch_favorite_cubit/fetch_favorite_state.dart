part of 'fetch_favorite_cubit.dart';

@immutable
sealed class FetchFavoriteState {}

final class FetchFavoriteInitial extends FetchFavoriteState {}
final class FetchFavoriteLoading extends FetchFavoriteState {}
final class FetchFavoriteSuccess extends FetchFavoriteState {
  final List<ProviderEntity> favorites;
  FetchFavoriteSuccess(this.favorites);
}
final class FetchFavoriteFailure extends FetchFavoriteState {
  final String message;
  FetchFavoriteFailure(this.message);
}
