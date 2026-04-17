import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/auth/view/auth_screen.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Widget _buildAuthApp() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthScreen()),
      GoRoute(
        path: AppRoute.signIn.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Sign In page'))),
      ),
      GoRoute(
        path: AppRoute.createAccount.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Create Account page'))),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}

void main() {
  group('AuthScreen', () {
    testWidgets('renders account sign in and create account actions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildAuthApp());
      await tester.pumpAndSettle();

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Sign in to your account'), findsOneWidget);
      expect(
        find.text('View your orders and fast-track your checkout experience'),
        findsOneWidget,
      );
      expect(find.byIcon(AppIcons.account), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'Sign in'), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'Create Account'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Help'), findsOneWidget);
    });

    testWidgets('navigates to sign in page when Sign in button is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildAuthApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(AppButton, 'Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('Sign In page'), findsOneWidget);
    });

    testWidgets(
      'navigates to create account page when Create Account button is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildAuthApp());
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(AppButton, 'Create Account'));
        await tester.pumpAndSettle();

        expect(find.text('Create Account page'), findsOneWidget);
      },
    );
  });
}
