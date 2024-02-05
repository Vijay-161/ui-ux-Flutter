import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shoe_store/core/failure/failure.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late UserEntity userEntity;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUsecase),
        ),
      ],
    );

    userEntity = UserEntity(
        fullName: 'jawed',
        email: 'jawed@gmail.com',
        phone: '9875486545',
        gender: 'Male',
        address: 'Ktm',
        username: 'vijay',
        password: 'vijay123');
  });

  test('check for the initial state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('register User wiht all entity', () async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(userEntity);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('Registering same user to return Invalid', () async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(userEntity);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(() {
    container.dispose();
  });
}
