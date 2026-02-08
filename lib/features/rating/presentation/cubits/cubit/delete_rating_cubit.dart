import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';

part 'delete_rating_state.dart';

class DeleteRatingCubit extends Cubit<DeleteRatingState> {
  DeleteRatingCubit(this._ratingRepo) : super(DeleteRatingInitial());

  final RatingRepo _ratingRepo;

  Future<void> deleteRating({
    required int ratingId,
    required BuildContext context,
  }) async {
    emit(DeleteRatingLoading());
    final result = await _ratingRepo.deleteRating(
      ratingId: ratingId,
      context: context,
    );
    result.fold(
      (failure) => emit(DeleteRatingFailure(failure.message)),
      (_) => emit(DeleteRatingSuccess()),
    );
  }
}
