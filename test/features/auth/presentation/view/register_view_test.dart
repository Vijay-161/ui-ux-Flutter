

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shoe_store/config/routes/app_route.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:shoe_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUsecase;
  // late BuildContext context;
  late UserEntity userEntity;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    userEntity = UserEntity(
        id: null,
        image: '',
        fullName: 'Vijay',
        email: 'jawed@gmail.com',
        phone: '9845154575',
        gender: 'Male',
        address: 'Ktm',
        username: 'vijay',
        password: 'vijay123');
  });
  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getAppRoutes(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Enter kiran in first textform field
    await tester.enterText(find.byType(TextFormField).at(0), 'vijay');
    // Enter kiran123 in second textform field
    await tester.enterText(find.byType(TextFormField).at(1), 'vijay@gmail.com');
    // Enter phone no
    await tester.enterText(find.byType(TextFormField).at(2), '9845154575');
    // Enter username
    await tester.enterText(find.byType(TextFormField).at(3), 'Ktm');

    // Enter password
    await tester.enterText(find.byType(TextFormField).at(4), 'vijay');
    await tester.enterText(find.byType(TextFormField).at(5), 'vijay123');
    await tester.tap(find.byType(RadioListTile).first);
    await tester.pumpAndSettle();

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Registered successfully'), findsOneWidget);
  });
}
