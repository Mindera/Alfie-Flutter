import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view/identification_screen.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  /// Builds a minimal MaterialApp with GoRouter to handle the required routes
  /// and verify navigation events triggered by the widget.
  Widget buildTestApp({Key? screenKey}) {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => Scaffold(
            body: ElevatedButton(
              onPressed: () => context.push('/identification'),
              child: const Text('Go to Identification'),
            ),
          ),
        ),
        GoRoute(
          path: '/identification',
          builder: (context, state) => ProviderScope(
            overrides: [
              userRepositoryProvider.overrideWithValue(mockUserRepository),
            ],
            child: IdentificationScreen(key: screenKey),
          ),
        ),
        GoRoute(
          path: AppRoute.signIn.fullPath,
          builder: (context, state) => Scaffold(
            body: Text('Sign In page: ${state.uri.queryParameters["email"]}'),
          ),
        ),
        GoRoute(
          path: AppRoute.createAccount.fullPath,
          builder: (context, state) => Scaffold(
            body: Text(
              'Create Account page: ${state.uri.queryParameters["email"]}',
            ),
          ),
        ),
        GoRoute(
          path: AppRoute.contactInformation.fullPath,
          builder: (context, state) =>
              const Scaffold(body: Text('Contact Information page')),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  /// Helper to safely navigate to the target screen to establish a navigation stack
  /// so that the back button (`context.safePop()`) can be tested without errors.
  Future<void> navigateToIdentification(
    WidgetTester tester, {
    Key? screenKey,
  }) async {
    await tester.pumpWidget(buildTestApp(screenKey: screenKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Go to Identification'));
    await tester.pumpAndSettle();
  }

  group('IdentificationScreen Widget Tests -', () {
    testWidgets('can be instantiated with a key', (WidgetTester tester) async {
      const key = Key('identification_screen_key');
      await navigateToIdentification(tester, screenKey: key);

      // Verify the widget is found via the key passed to the constructor
      expect(find.byKey(key), findsOneWidget);
      expect(find.byType(IdentificationScreen), findsOneWidget);
    });

    testWidgets('renders correctly with all UI elements', (
      WidgetTester tester,
    ) async {
      await navigateToIdentification(tester);

      expect(find.text('Identification'), findsOneWidget);
      expect(find.text('Sign In or Create Account'), findsOneWidget);
      expect(find.byType(AppInputField), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'Continue'), findsOneWidget);
      expect(find.text('CONTINUE AS GUEST'), findsOneWidget);
      expect(
        find.widgetWithText(AppButton, 'Continue with Facebook'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(AppButton, 'Continue with Apple'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(AppButton, 'Continue with Google'),
        findsOneWidget,
      );
      expect(find.byIcon(AppIcons.back), findsOneWidget);
    });

    testWidgets('tapping back button pops the screen', (
      WidgetTester tester,
    ) async {
      await navigateToIdentification(tester);

      expect(find.byType(IdentificationScreen), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(find.byType(IdentificationScreen), findsNothing);
      expect(find.text('Go to Identification'), findsOneWidget);
    });

    testWidgets('tapping Continue with invalid email shows SnackBar', (
      WidgetTester tester,
    ) async {
      await navigateToIdentification(tester);

      await tester.tap(find.widgetWithText(AppButton, 'Continue'));
      await tester.pump();

      expect(find.text('Please enter a valid email address.'), findsOneWidget);
    });

    testWidgets('navigates to signIn route if valid email is registered', (
      WidgetTester tester,
    ) async {
      when(
        () => mockUserRepository.isEmailRegistered('test@example.com'),
      ).thenReturn(true);

      await navigateToIdentification(tester);

      await tester.enterText(
        find.byType(EditableText).first,
        'test@example.com',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(AppButton, 'Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Sign In page: test@example.com'), findsOneWidget);
    });

    testWidgets(
      'navigates to createAccount route if valid email is NOT registered',
      (WidgetTester tester) async {
        when(
          () => mockUserRepository.isEmailRegistered('newuser@example.com'),
        ).thenReturn(false);

        await navigateToIdentification(tester);

        await tester.enterText(
          find.byType(EditableText).first,
          'newuser@example.com',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(AppButton, 'Continue'));
        await tester.pumpAndSettle();

        expect(
          find.text('Create Account page: newuser@example.com'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'navigates to contactInformation route when tapping CONTINUE AS GUEST',
      (WidgetTester tester) async {
        await navigateToIdentification(tester);

        await tester.tap(find.text('CONTINUE AS GUEST'));
        await tester.pumpAndSettle();

        expect(find.text('Contact Information page'), findsOneWidget);
      },
    );

    testWidgets('social login buttons can be tapped without throwing errors', (
      WidgetTester tester,
    ) async {
      await navigateToIdentification(tester);

      // Verify tapping Facebook button
      await tester.tap(
        find.widgetWithText(AppButton, 'Continue with Facebook'),
      );
      await tester.pumpAndSettle();

      // Verify tapping Apple button
      await tester.tap(find.widgetWithText(AppButton, 'Continue with Apple'));
      await tester.pumpAndSettle();

      // Verify tapping Google button
      await tester.tap(find.widgetWithText(AppButton, 'Continue with Google'));
      await tester.pumpAndSettle();

      // Since the current implementation has empty closures () {}, we simply assert
      // that tapping them doesn't throw exceptions and we remain on the screen.
      expect(find.byType(IdentificationScreen), findsOneWidget);
    });
  });
}
