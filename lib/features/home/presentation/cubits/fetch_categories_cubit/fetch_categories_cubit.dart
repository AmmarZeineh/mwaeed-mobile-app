import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/domain/repos/home_repo.dart';

part 'fetch_categories_state.dart';

class FetchCategoriesCubit extends Cubit<FetchCategoriesState> {
  FetchCategoriesCubit(this._homeRepo) : super(FetchCategoriesInitial());
  int skip = 0;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;
  final HomeRepo _homeRepo;
  List<CategoryEntitiy> categories = [];

  Future<void> getCategories({bool loadMore = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (!loadMore) {
      emit(FetchCategoriesLoading());
      categories = [];
      skip = 0;
      hasMore = true;
    }

    var result = await _homeRepo.getCategories(skip: skip, limit: limit);

    result.fold((failure) => emit(FetchCategoriesFailure(failure.message)), (
      newCategories,
    ) {
      if (newCategories.isEmpty) {
        hasMore = false;
      } else {
        skip += limit;
        categories.addAll(newCategories);
      }
      emit(FetchCategoriesSuccess(categories, hasMore: hasMore));
    });

    isLoading = false;
  }
}
