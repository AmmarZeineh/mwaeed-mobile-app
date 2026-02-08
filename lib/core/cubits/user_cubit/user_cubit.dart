import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  /// Set user data and emit UserLoaded state
  void setUser(UserEntity user) {
    emit(UserLoaded(user));
  }

  /// Clear user data and return to initial state (logout)
  void clearUser() {
    emit(UserInitial());
  }

  /// Update user profile information
  void updateUser(UserEntity updatedUser) {
    if (state is UserLoaded) {
      emit(UserLoaded(updatedUser));
    }
  }

  /// Update user name
  void updateUserName(String newName) {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final updatedUser = currentUser.copyWith(name: newName);
      emit(UserLoaded(updatedUser));
    }
  }

  /// Update user phone
  void updateUserPhone(String newPhone) {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final updatedUser = currentUser.copyWith(phoneNumber: newPhone);
      emit(UserLoaded(updatedUser));
    }
  }

  /// Update user city
  void updateUserCity(String newCity) {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final updatedUser = currentUser.copyWith(city: newCity);
      emit(UserLoaded(updatedUser));
    }
  }

  /// Update multiple user fields at once
  void updateUserProfile({
    String? name,
    String? phone,
    String? city,
    String? profileImage,
    String? preferredLanguage,
  }) {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final updatedUser = currentUser.copyWith(
        name: name,
        phoneNumber: phone,
        city: city,
      );
      emit(UserLoaded(updatedUser));
    }
  }

  /// Start loading state (useful for API calls)
  void setLoading() {
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      emit(UserLoading(currentUser));
    } else {
      emit(UserLoadingInitial());
    }
  }

  /// Handle error state
  void setError(String errorMessage, [UserEntity? user]) {
    if (user != null) {
      emit(UserError(errorMessage, user));
    } else if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      emit(UserError(errorMessage, currentUser));
    } else {
      emit(UserErrorInitial(errorMessage));
    }
  }

  /// Clear error and return to previous valid state
  void clearError() {
    if (state is UserError) {
      final errorState = state as UserError;
      if (errorState.user != null) {
        emit(UserLoaded(errorState.user!));
      } else {
        emit(UserInitial());
      }
    } else if (state is UserErrorInitial) {
      emit(UserInitial());
    }
  }

  // Getters
  /// Get current user (null if not logged in)
  UserEntity? get currentUser {
    if (state is UserLoaded) {
      return (state as UserLoaded).user;
    } else if (state is UserLoading) {
      return (state as UserLoading).user;
    } else if (state is UserError) {
      return (state as UserError).user;
    }
    return null;
  }

  /// Check if user is logged in
  bool get isLoggedIn =>
      state is UserLoaded || state is UserLoading || state is UserError;

  /// Check if currently loading
  bool get isLoading => state is UserLoading || state is UserLoadingInitial;

  /// Check if there's an error
  bool get hasError => state is UserError || state is UserErrorInitial;

  /// Get current error message
  String? get errorMessage {
    if (state is UserError) {
      return (state as UserError).message;
    } else if (state is UserErrorInitial) {
      return (state as UserErrorInitial).message;
    }
    return null;
  }

  /// Get user name (empty string if not available)
  String get userName => currentUser?.name ?? '';

  /// Get user email (empty string if not available)
  String get userEmail => currentUser?.email ?? '';

  /// Get user phone (empty string if not available)
  String get userPhone => currentUser?.phoneNumber ?? '';

  /// Get user city (empty string if not available)
  String get userCity => currentUser?.city ?? '';
}
