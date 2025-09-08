part of 'add_favorite_cubit.dart';

@immutable
abstract class AddFavoriteState {}

class AddFavoriteInitial extends AddFavoriteState {}

class AddFavoriteLoading extends AddFavoriteState {}

class AddFavoriteSuccess extends AddFavoriteState {
  final bool isFavorite;
  AddFavoriteSuccess({required this.isFavorite});
}

class AddFavoriteFailure extends AddFavoriteState {
  final String message;
  AddFavoriteFailure(this.message);
}
