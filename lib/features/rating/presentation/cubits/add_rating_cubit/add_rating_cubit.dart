import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';

part 'add_rating_state.dart';

class AddRatingCubit extends Cubit<AddRatingState> {
  AddRatingCubit(this._ratingRepo) : super(AddRatingInitial());
  final RatingRepo _ratingRepo;

  Future<void> submitRating({
    required int appointmentId,
    required int providerId,
    required int rating,
    required String? comment,
    required context,
  }) async {
    emit(AddRatingLoading());
    var result = await _ratingRepo.submitRating(
      appointmentId: appointmentId,
      providerId: providerId,
      rating: rating,
      comment: comment,
      context: context,
    );
    result.fold(
      (failure) => emit(AddRatingFailure(failure.message)),
      (_) => emit(AddRatingSuccess()),
    );
  }
}
