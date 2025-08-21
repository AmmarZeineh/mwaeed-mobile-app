import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  void setUser(UserEntity user) {
    emit(UserLoaded(user));
  }

  void clearUser() {
    emit(UserInitial());
  }

  UserEntity? get currentUser =>
      state is UserLoaded ? (state as UserLoaded).user : null;

  bool get isLoggedIn => state is UserLoaded;

}
