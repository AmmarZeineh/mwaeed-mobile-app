import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/home/domain/repos/home_repo.dart';

part 'fetch_providers_state.dart';

class FetchProvidersCubit extends Cubit<FetchProvidersState> {
  FetchProvidersCubit(this._homeRepo) : super(FetchProvidersInitial());

  final HomeRepo _homeRepo;
  int skip = 0;
  final int limit = 10;
  bool isLoadingProviders = false;
  bool hasMoreProviders = true;
  List<ProviderEntity> providers = [];
  Future<void> getProviders({bool loadMore = false}) async {
    if (isLoadingProviders || !hasMoreProviders) return;

    isLoadingProviders = true;

    if (!loadMore) {
      emit(FetchProvidersLoading());
      providers = [];
      skip = 0;
      hasMoreProviders = true;
    }

    final result = await _homeRepo.getProviders(skip: skip, limit: limit);

    result.fold(
      (failure) {
        emit(FetchProvidersFailure(failure.message));
      },
      (newProviders) {
        if (newProviders.isEmpty) {
          hasMoreProviders = false;
        } else {
          skip += limit;
          providers.addAll(newProviders);
        }

        emit(FetchProvidersSuccess(providers, hasMore: hasMoreProviders));
      },
    );

    isLoadingProviders = false;
  }
}
