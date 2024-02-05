import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(mockAuthUsecase),
      ),
    ]);
  });

  test('Test initial state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('login test with valid username and password', () async {
    when(mockAuthUsecase.loginUser('vijay', 'vijay123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'vijay', 'vijay123');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('login test with invalid username and password', () async {
    when(mockAuthUsecase.loginUser('vijay', 'vijay1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'vijay', 'vijay1234');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid');
  });
  
  tearDownAll(() {
    container.dispose();
  });
}
