import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authReomteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);
  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> checkUser(String username) {
    return _authRemoteDataSource.checkUser(username);
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String username) {
    return _authRemoteDataSource.getUser(username);
  }
}
