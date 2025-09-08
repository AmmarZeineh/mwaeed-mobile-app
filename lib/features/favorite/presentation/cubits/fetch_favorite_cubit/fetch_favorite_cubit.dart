import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mwaeed_mobile_app/features/favorite/domain/repos/favorite_repo.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

part 'fetch_favorite_state.dart';

class FetchFavoriteCubit extends Cubit<FetchFavoriteState> {
  FetchFavoriteCubit(this.favoriteRepo) : super(FetchFavoriteInitial());
  final FavoriteRepo favoriteRepo;
  Future<void> getFavorites({required BuildContext context}) async {
    emit(FetchFavoriteLoading());
    final result = await favoriteRepo.fetchFavoriteProvidersIds(
      context: context,
    );
    result.fold(
      (l) => emit(FetchFavoriteFailure(l.message)),
      (r) => emit(FetchFavoriteSuccess(r)),
    );
  }
}
