import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());
  final ProfileRepo _profileRepo;

  Future<void> updateUserData({
    required Map<String, dynamic> body,
    required int userId,
  }) async {
    emit(ProfileLoading());
    var result = await _profileRepo.updateUserData(body: body, userId: userId);
    result.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(ProfileSuccess()),
    );
  }

  Future<void> getCities() async {
    emit(ProfileLoading());
    var result = await _profileRepo.getCities();
    result.fold(
      (l) => emit(ProfileFailure(l.message)),
      (r) => emit(ProfileCitiesLoaded(r)),
    );
  }
}
