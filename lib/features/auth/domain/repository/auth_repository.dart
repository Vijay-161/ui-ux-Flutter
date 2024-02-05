import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_local_repo.dart';
import '../../data/repository/auth_remote_repo.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // return ref.read(authLocalRepositoryProvider);
  // Check for the internet
  final internetStatus = ref.watch(connectivityStatusProvider);

  if (ConnectivityStatus.isConnected == internetStatus) {
    // If internet is available then return remote repo
    return ref.watch(authRemoteRepositoryProvider);
  } else {
    // If internet is not available then return local repo
    return ref.watch(authLocalRepositoryProvider);
  }
  // return ref.watch(authLocalRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> checkUser(String username);
  Future<Either<Failure, UserEntity>> getUser(String username);
}
