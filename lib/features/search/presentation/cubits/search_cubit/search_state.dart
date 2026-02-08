part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoadingMore extends SearchState {}

final class SearchFailure extends SearchState {
  final String errMessage;
  SearchFailure(this.errMessage);
}

final class SearchLoadMoreFailure extends SearchState {
  final String errMessage;
  SearchLoadMoreFailure(this.errMessage);
}

final class SearchSuccess extends SearchState {
  final bool hasMoreData;
  SearchSuccess({required this.hasMoreData});
}
