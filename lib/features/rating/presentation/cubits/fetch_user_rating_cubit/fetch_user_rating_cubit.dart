import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';

part 'fetch_user_rating_state.dart';

class FetchUserRatingCubit extends Cubit<FetchUserRatingState> {
  FetchUserRatingCubit(this._ratingRepo) : super(FetchUserRatingInitial());
  final RatingRepo _ratingRepo;

  Future<void> getUserRatingForSpicificProvider({
    required int providerId,
    required context,
  }) async {
    emit(FetchUserRatingLoading());
    var result = await _ratingRepo.getUserRatingForSpicificProvider(
      context: context,
      providerId: providerId,
    );
    result.fold((failure) => emit(FetchUserRatingFailure(failure.message)), (
      ratingEntity,
    ) {
      emit(FetchUserRatingSuccess(ratingEntity));
    });
  }
}
