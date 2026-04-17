import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/auth/view/create_account_screen.dart';
import 'package:alfie_flutter/ui/auth/view_model/auth_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FakeAuthViewModel extends AuthViewModel {
  final bool shouldSucceed;
  final bool shouldThrow;

  FakeAuthViewModel({this.shouldSucceed = true, this.shouldThrow = false});

  @override
  User? build() => null;

  @override
  User createAccount(UserData userData) {
    if (shouldThrow) {
      throw Exception('Create account failed');
    }
    return User(id: 'user-id', data: userData);
  }
}

Widget _buildCreateAccountApp({
  bool shouldSucceed = true,
  bool shouldThrow = false,
  String initialLocation = '/createAccount',
}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home page'))),
      ),
      GoRoute(
        path: '/createAccount',
        builder: (context, state) => ProviderScope(
          overrides: [
            authViewModelProvider.overrideWith(
              () => FakeAuthViewModel(
                shouldSucceed: shouldSucceed,
                shouldThrow: shouldThrow,
              ),
            ),
          ],
          child: const CreateAccountScreen(),
        ),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}

void main() {
  group('CreateAccountScreen', () {
    testWidgets('renders form fields and taps back button using GoRouter', (
      WidgetTester tester,
    ) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Home page'))),
          ),
          GoRoute(
            path: '/createAccount',
            builder: (context, state) => ProviderScope(
              overrides: [
                authViewModelProvider.overrideWith(() => FakeAuthViewModel()),
              ],
              child: const CreateAccountScreen(),
            ),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      router.push('/createAccount');
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppButton, 'Create Account'), findsOneWidget);
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(find.text('Home page'), findsOneWidget);
    });

    testWidgets('does not submit when form is invalid', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildCreateAccountApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(AppButton, 'Create Account'));
      await tester.pumpAndSettle();

      expect(find.text('Home page'), findsNothing);
      expect(find.text('Account created successfully!'), findsNothing);
    });

    testWidgets(
      'shows success snackbar and pops when account creation succeeds',
      (WidgetTester tester) async {
        final router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Home page'))),
            ),
            GoRoute(
              path: '/createAccount',
              builder: (context, state) => ProviderScope(
                overrides: [
                  authViewModelProvider.overrideWith(
                    () => FakeAuthViewModel(shouldSucceed: true),
                  ),
                ],
                child: const CreateAccountScreen(),
              ),
            ),
          ],
        );

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));
        router.push('/createAccount');
        await tester.pumpAndSettle();

        final fields = find.byType(TextFormField);
        expect(fields, findsNWidgets(5));

        await tester.enterText(fields.at(0), 'Jane');
        await tester.enterText(fields.at(1), 'Doe');
        await tester.enterText(fields.at(2), 'jane.doe@example.com');
        await tester.enterText(fields.at(3), 'Password123!');
        await tester.enterText(fields.at(4), '+1234567890');

        final termsCheckbox = find.widgetWithText(
          CheckboxTile,
          r"I've read and agreed with User Terms and Conditions of Service.",
        );
        await tester.ensureVisible(termsCheckbox);
        await tester.tap(termsCheckbox);
        await tester.pumpAndSettle();

        final newsletterCheckbox = find.widgetWithText(
          CheckboxTile,
          r"I want to receive news and special offers via email.",
        );
        await tester.ensureVisible(newsletterCheckbox);
        await tester.tap(newsletterCheckbox);
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(AppButton, 'Create Account'));
        await tester.pumpAndSettle();

        expect(find.text('Home page'), findsOneWidget);
        expect(find.widgetWithText(AppButton, 'Create Account'), findsNothing);
      },
    );

    testWidgets(
      'shows error snackbar and remains on screen when create account fails',
      (WidgetTester tester) async {
        final router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Home page'))),
            ),
            GoRoute(
              path: '/createAccount',
              builder: (context, state) => ProviderScope(
                overrides: [
                  authViewModelProvider.overrideWith(
                    () => FakeAuthViewModel(shouldThrow: true),
                  ),
                ],
                child: const CreateAccountScreen(),
              ),
            ),
          ],
        );

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));
        router.push('/createAccount');
        await tester.pumpAndSettle();

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), 'Jane');
        await tester.enterText(fields.at(1), 'Doe');
        await tester.enterText(fields.at(2), 'jane.doe@example.com');
        await tester.enterText(fields.at(3), 'Password123!');
        await tester.enterText(fields.at(4), '+1234567890');

        final termsCheckbox = find.widgetWithText(
          CheckboxTile,
          r"I've read and agreed with User Terms and Conditions of Service.",
        );
        await tester.ensureVisible(termsCheckbox);
        await tester.tap(termsCheckbox);
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(AppButton, 'Create Account'));
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(AppButton, 'Create Account'),
          findsOneWidget,
        );
        expect(
          find.text(
            'Could not create account: Exception: Create account failed',
          ),
          findsOneWidget,
        );
      },
    );
  });
}
