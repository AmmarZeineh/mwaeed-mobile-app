import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';

part 'edit_rating_state.dart';

class EditRatingCubit extends Cubit<EditRatingState> {
  EditRatingCubit(this._ratingRepo) : super(EditRatingInitial());
  final RatingRepo _ratingRepo;

  Future<void> editRating({
    required BuildContext context,
    required int providerId,
    required int appointmentId,
    required int ratingId,

    required int rating,
    required String? comment,
  }) async {
    emit(EditRatingLoading());
    var result = await _ratingRepo.editRating(
      ratingId: ratingId,
      context: context,
      providerId: providerId,
      appointmentId: appointmentId,
      rating: rating,
      comment: comment,
    );
    result.fold((failure) => emit(EditRatingFailure(failure.message)), (_) {
      emit(EditRatingSuccess());
    });
  }
}
