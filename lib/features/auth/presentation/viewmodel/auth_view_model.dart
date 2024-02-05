import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:shoe_store/features/auth/presentation/state/auth_state.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.read(authUseCaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initial());

  Future<void> registerUser(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.loginUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        checkUser(context, username);
        getUser(context, username);
      },
    );
  }

  Future<void> checkUser(BuildContext context, String username) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.checkUser(username);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // Navigator.popAndPushNamed(context, AppRoute.homeRoute);
        if (success == true) {
          Navigator.popAndPushNamed(context, AppRoute.adminDashboardRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        }
      },
    );
  }

  Future<void> getUser(BuildContext context, String username) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.getUser(username);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state =
            state.copyWith(isLoading: false, currentUser: success, error: null);
      },
    );
  }

  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
    }, (imageName) {
      state = state.copyWith(isLoading: false, imageName: imageName);
    });
  }
}
