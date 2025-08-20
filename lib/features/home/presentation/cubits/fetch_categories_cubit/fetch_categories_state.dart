part of 'fetch_categories_cubit.dart';

@immutable
sealed class FetchCategoriesState {}

final class FetchCategoriesInitial extends FetchCategoriesState {}

final class FetchCategoriesLoading extends FetchCategoriesState {}

final class FetchCategoriesSuccess extends FetchCategoriesState {
  final List<CategoryEntitiy> categories;
  final bool hasMore;
  FetchCategoriesSuccess(this.categories, {required this.hasMore});
}

final class FetchCategoriesFailure extends FetchCategoriesState {
  final String errMessage;

  FetchCategoriesFailure(this.errMessage);
}
