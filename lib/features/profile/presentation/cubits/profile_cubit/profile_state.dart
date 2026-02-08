part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String errMessage;

  ProfileFailure(this.errMessage);
}

final class ProfileSuccess extends ProfileState {}

final class ProfileCitiesLoaded extends ProfileState {
  final List<CityEntity> cities;

  ProfileCitiesLoaded(this.cities);
}
