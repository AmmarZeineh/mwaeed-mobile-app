part of 'fetch_providers_cubit.dart';

@immutable
sealed class FetchProvidersState {}

final class FetchProvidersInitial extends FetchProvidersState {}

final class FetchProvidersLoading extends FetchProvidersState {}

final class FetchProvidersFailure extends FetchProvidersState {
  final String errMessage;

  FetchProvidersFailure(this.errMessage);
}

final class FetchProvidersSuccess extends FetchProvidersState {
  final List<ProviderEntity> providers;
  final bool hasMore;
  FetchProvidersSuccess(this.providers, {required this.hasMore});
}
