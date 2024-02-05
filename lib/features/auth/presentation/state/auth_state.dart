import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final UserEntity? currentUser;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.currentUser,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      currentUser: null,
    );
  }

  AuthState copyWith(
      {bool? isLoading,
      String? error,
      String? imageName,
      UserEntity? currentUser}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, imageName:$imageName, currentUser: $currentUser)';
}
