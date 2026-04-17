import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/auth/view/sign_in_screen.dart';
import 'package:alfie_flutter/ui/auth/view_model/auth_view_model.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FakeAuthViewModel extends AuthViewModel {
  final bool signInResult;

  FakeAuthViewModel(this.signInResult);

  @override
  User? build() => null;

  @override
  bool signIn(String email, String password) => signInResult;
}

Widget _buildGoRouterTestApp({required bool signInSucceeds}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ProviderScope(
          overrides: [
            authViewModelProvider.overrideWith(
              () => FakeAuthViewModel(signInSucceeds),
            ),
          ],
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.account.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Account page'))),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}

void main() {
  group('SignInScreen', () {
    testWidgets('renders form fields and allows tapping forgot password', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildGoRouterTestApp(signInSucceeds: false));

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);

      await tester.tap(find.text('Forgot password?'));
      await tester.pumpAndSettle();

      // No navigation or error should occur for the empty forgot password handler.
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('shows invalid email or password snackbar when sign in fails', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildGoRouterTestApp(signInSucceeds: false));

      final fields = find.byType(TextFormField);
      expect(fields, findsNWidgets(2));

      await tester.enterText(fields.first, 'wrong@example.com');
      await tester.enterText(fields.at(1), 'bad-password');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email or password'), findsOneWidget);
      expect(find.text('Account page'), findsNothing);
    });

    testWidgets('navigates to account page when sign in succeeds', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildGoRouterTestApp(signInSucceeds: true));

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'success@example.com');
      await tester.enterText(fields.at(1), 'correct-password');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      expect(find.text('Account page'), findsOneWidget);
    });
  });
}
