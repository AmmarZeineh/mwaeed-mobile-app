
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/search/domain/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  final SearchRepo searchRepo;
  List<ProviderEntity> providers = [];

  // Pagination variables
  int _currentSkip = 0;
  final int _limit = 10;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  String _currentSearchString = '';
  int _currentSearchId = 0;

  Future<void> search(
    String searchString,
    int searchId, {
    bool isNewSearch = true,
  }) async {
    if (isNewSearch) {
      // Reset for new search
      _currentSkip = 0;
      _hasMoreData = true;
      _currentSearchString = searchString;
      _currentSearchId = searchId;
      providers.clear();
      emit(SearchLoading());
    } else {
      // Load more data
      if (!_hasMoreData || _isLoadingMore) return;
      _isLoadingMore = true;
      emit(SearchLoadingMore());
    }

    final result = await searchRepo.search(
      searchString: isNewSearch ? searchString : _currentSearchString,
      searchId: isNewSearch ? searchId : _currentSearchId,
      skip: _currentSkip,
      limit: _limit,
    );

    _isLoadingMore = false;

    result.fold(
      (failure) {
        if (isNewSearch) {
          emit(SearchFailure(failure.message));
        } else {
          emit(SearchLoadMoreFailure(failure.message));
        }
      },
      (newProviders) {
        if (newProviders.isEmpty) {
          _hasMoreData = false;
        } else {
          providers.addAll(newProviders);
          _currentSkip += _limit;
        }
        emit(SearchSuccess(hasMoreData: _hasMoreData));
      },
    );
  }

  Future<void> loadMore() async {
    if (_currentSearchString.isNotEmpty) {
      await search(_currentSearchString, _currentSearchId, isNewSearch: false);
    }
  }

  void clearSearch() {
    providers.clear();
    _currentSkip = 0;
    _hasMoreData = true;
    _currentSearchString = '';
    _currentSearchId = 0;
    emit(SearchInitial());
  }
}
