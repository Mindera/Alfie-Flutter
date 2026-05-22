import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view/order_confirmation_screen.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/fakes/checkout_view_model_fake.dart';
import '../../../testing/mocks.dart';

void main() {
  late MockCheckoutState mockCheckoutState;
  late MockUserData mockUserData;
  late FakeCheckoutViewModel testViewModel;

  setUp(() {
    mockCheckoutState = MockCheckoutState();
    mockUserData = MockUserData();

    // Stub the state to return our mock user data
    when(() => mockCheckoutState.userData).thenReturn(mockUserData);

    testViewModel = FakeCheckoutViewModel(mockCheckoutState);
  });

  Widget buildTestApp({Key? screenKey}) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => OrderConfirmationScreen(key: screenKey),
        ),
        GoRoute(
          path: AppRoute.home.fullPath,
          builder: (context, state) => const Scaffold(body: Text('Home Page')),
        ),
        GoRoute(
          path: AppRoute.createAccount.fullPath,
          builder: (context, state) {
            // Verify if the expected userData is passed in the navigation extra
            final passedData = state.extra as UserData?;
            final isCorrectData = passedData == mockUserData;

            return Scaffold(
              body: Text(
                isCorrectData
                    ? 'Create Account Page (Valid Data)'
                    : 'Create Account Page (Invalid Data)',
              ),
            );
          },
        ),
      ],
    );

    return ProviderScope(
      overrides: [checkoutViewModelProvider.overrideWith(() => testViewModel)],
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return MaterialApp.router(
            routerConfig: router,
            theme: ref.watch(themeProvider),
          );
        },
      ),
    );
  }

  group('OrderConfirmationScreen Tests -', () {
    testWidgets('renders success texts and correct action buttons', (
      WidgetTester tester,
    ) async {
      final testKey = Key("test-key");
      await tester.pumpWidget(buildTestApp(screenKey: testKey));

      // Verify textual content
      expect(find.text('Thank you!'), findsOneWidget);
      expect(find.text('ORDER NUMBER #1A2B3C4D'), findsOneWidget);
      expect(
        find.textContaining('We sent an email to email@email.com'),
        findsOneWidget,
      );

      // Verify buttons
      expect(find.byIcon(AppIcons.close), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'Create account'), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'View order'), findsOneWidget);
    });

    testWidgets(
      'tapping close app bar button clears checkout state and navigates to home',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        await tester.tap(find.byIcon(AppIcons.close));
        await tester.pumpAndSettle();

        // Assert side effects and navigation
        expect(testViewModel.clearStateCalled, isTrue);
        expect(find.text('Home Page'), findsOneWidget);
      },
    );

    testWidgets(
      'tapping Create account button clears state and passes user data via extra',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        await tester.tap(find.widgetWithText(AppButton, 'Create account'));
        await tester.pumpAndSettle();

        // Assert side effects and correct navigation payload parsing
        expect(testViewModel.clearStateCalled, isTrue);
        expect(find.text('Create Account Page (Valid Data)'), findsOneWidget);
      },
    );

    testWidgets(
      'tapping View order button executes empty callback without crashing',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        await tester.tap(find.widgetWithText(AppButton, 'View order'));
        await tester.pumpAndSettle();

        // Verify we stay on the same screen and no exceptions occurred
        expect(find.text('Thank you!'), findsOneWidget);
      },
    );
  });
}
