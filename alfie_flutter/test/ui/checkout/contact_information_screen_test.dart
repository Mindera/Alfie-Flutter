import 'dart:io';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view/contact_information_screen.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/checkout_view_model_fake.dart';

Widget _buildApp({
  required FakeCheckoutViewModel mockViewModel,
  String initialLocation = '/contact',
  Key? screenKey,
}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => Scaffold(
          body: ElevatedButton(
            onPressed: () => context.push('/contact'),
            child: const Text('Go to Contact'),
          ),
        ),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => ContactInformationScreen(key: screenKey),
      ),
      GoRoute(
        path: AppRoute.deliveryInformation.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Text('Delivery Information Screen')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [checkoutViewModelProvider.overrideWith(() => mockViewModel)],
    child: MaterialApp.router(routerConfig: router),
  );
}

// --- Test Suite ---

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });

  group('ContactInformationScreen Widget Tests -', () {
    testWidgets(
      'renders correctly with empty initial state and prevents submission',
      (WidgetTester tester) async {
        final mockViewModel = FakeCheckoutViewModel();

        const testKey = Key('contact_info_screen');

        await tester.pumpWidget(
          _buildApp(mockViewModel: mockViewModel, screenKey: testKey),
        );
        await tester.pumpAndSettle();

        expect(find.text('Contact Info'), findsOneWidget);
        expect(find.text('Contact Details'), findsOneWidget);

        // Verify fields are present
        final textFields = find.byType(TextFormField);
        expect(textFields, findsNWidgets(4));

        // Attempt to submit an empty form
        await tester.tap(find.widgetWithText(AppButton, 'Continue'));
        await tester.pumpAndSettle();

        // Should not navigate because the form is invalid
        expect(find.text('Delivery Information Screen'), findsNothing);
        expect(find.text('Contact Details'), findsOneWidget);
      },
    );
    // contact_information_screen_test.dart (updated test case)

    testWidgets(
      'updates state and enables button when fields are filled (onChanged)',
      (WidgetTester tester) async {
        final mockViewModel = FakeCheckoutViewModel();

        await tester.pumpWidget(_buildApp(mockViewModel: mockViewModel));
        await tester.pumpAndSettle();

        // Use index-based finders to reliably reach the internal TextFormField/EditableText
        await tester.enterText(find.byType(TextFormField).at(0), 'John');
        await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
        await tester.enterText(
          find.byType(TextFormField).at(2),
          'john@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(3), '1234567890');

        await tester.pumpAndSettle();

        // Verify the button is now enabled
        final continueButton = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Continue'),
        );
        expect(continueButton.isDisabled, isFalse);

        // Tap Continue and verify ViewModel update
        await tester.tap(find.widgetWithText(AppButton, 'Continue'));
        await tester.pumpAndSettle();

        expect(mockViewModel.savedUser?.firstName, 'John');
        expect(find.text('Delivery Information Screen'), findsOneWidget);
      },
    );

    testWidgets('renders pre-filled data and allows navigation if valid', (
      WidgetTester tester,
    ) async {
      final userData = UserData(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@example.com',
        phoneNumber: '1234567890',
      );

      final mockViewModel = FakeCheckoutViewModel(
        CheckoutState(userData: userData),
      );

      await tester.pumpWidget(_buildApp(mockViewModel: mockViewModel));
      await tester.pumpAndSettle();

      // Verify text fields are pre-populated
      expect(find.text('Jane'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('jane@example.com'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);

      // Tap Continue
      await tester.tap(find.widgetWithText(AppButton, 'Continue'));
      await tester.pumpAndSettle();

      // Navigation should be successful
      expect(find.text('Delivery Information Screen'), findsOneWidget);
      // User should be updated via the view model
      expect(mockViewModel.savedUser?.firstName, 'Jane');
    });

    testWidgets('tapping back button navigates back via safePop', (
      WidgetTester tester,
    ) async {
      final mockViewModel = FakeCheckoutViewModel();

      // Start at the home screen so that the router has history to pop back to
      await tester.pumpWidget(
        _buildApp(mockViewModel: mockViewModel, initialLocation: '/home'),
      );
      await tester.pumpAndSettle();

      // Navigate to Contact screen
      await tester.tap(find.text('Go to Contact'));
      await tester.pumpAndSettle();
      expect(find.text('Contact Details'), findsOneWidget);

      // Tap back button in the App bar / Header
      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      // Should return to the simulated Home Screen
      expect(find.text('Go to Contact'), findsOneWidget);
      expect(find.text('Contact Details'), findsNothing);
    });
  });
}
