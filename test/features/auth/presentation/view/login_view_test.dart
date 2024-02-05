import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shoe_store/config/routes/app_route.dart';
import 'package:shoe_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:shoe_store/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  late bool isLogin;
  setUpAll(() {
    mockAuthUseCase = MockAuthUseCase();
    isLogin = true;
  });
  testWidgets('login test with username and password', (tester) async {
    when(mockAuthUseCase.loginUser('vijay', 'vijay123'))
        .thenAnswer((_) async => Right(isLogin));
    await tester.pumpWidget(
      ProviderScope(
          overrides: [
            authViewModelProvider
                .overrideWith((ref) => AuthViewModel(mockAuthUseCase))
          ],
          child: MaterialApp(
            initialRoute: AppRoute.loginRoute,
            routes: AppRoute.getAppRoutes(),
          )),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'vijay');
    await tester.enterText(find.byType(TextFormField).at(1), 'vijay123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // expect(find.text("Dashboard"), findsOneWidget);
  });
}
