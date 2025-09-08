import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/favorite/domain/repos/favorite_repo.dart';

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteState> {
  AddFavoriteCubit(this.favoriteRepo) : super(AddFavoriteInitial());

  final FavoriteRepo favoriteRepo;

  Future<void> toggleFavorite({
    required int providerId,
    required context,
    required bool isFavorite, // الحالة الحالية
  }) async {
    emit(AddFavoriteLoading());

    final result = isFavorite
        ? await favoriteRepo.removeFromFavorite(
            context: context,
            providerId: providerId,
          )
        : await favoriteRepo.addToFavorite(
            context: context,
            providerId: providerId,
          );

    result.fold(
      (l) => emit(AddFavoriteFailure(l.message)),
      (r) =>
          emit(AddFavoriteSuccess(isFavorite: !isFavorite)), // الحالة الجديدة
    );
  }
}
