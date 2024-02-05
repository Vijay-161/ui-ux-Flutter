import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';

class SplashState {
  final bool isLoading;
  final String? error;
  final UserEntity user;

  SplashState({
    required this.isLoading,
    this.error,
    required this.user,
  });

  factory SplashState.initial() {
    return SplashState(
      isLoading: false,
      error: null,
      user: UserEntity(fullName: 'ddd', email: 'ddd', phone: 'ddd', gender: 
      'ddd', address: 'ddd', username: 'ddd', password: ''),
    );
  }

  SplashState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? error,
    
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
