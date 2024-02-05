import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/failure/failure.dart';

final authUseCaseProvider = Provider(
  (ref) => AuthUseCase(
    ref.read(authRepositoryProvider),
  ),
);

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return await _authRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    return await _authRepository.loginUser(username, password);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> checkUser(
      String username) async {
    return await _authRepository.checkUser(username);
  }

  Future<Either<Failure, UserEntity>> getUser(
      String username) async {
    return await _authRepository.getUser(username);
  }
}
