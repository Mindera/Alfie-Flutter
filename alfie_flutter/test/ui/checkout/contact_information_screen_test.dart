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

    testWidgets('filling fields manually enables submission and trims inputs', (
      WidgetTester tester,
    ) async {
      final mockViewModel = FakeCheckoutViewModel();
      await tester.pumpWidget(_buildApp(mockViewModel: mockViewModel));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);

      // Enter input. Names have spaces to test .trim() logic.
      // Email and Phone are entered without spaces to pass strict validation.
      await tester.enterText(textFields.at(0), ' John ');
      await tester.enterText(textFields.at(1), ' Smith ');
      await tester.enterText(textFields.at(2), 'john@example.com');
      await tester.enterText(textFields.at(3), '0987654321');

      // Trigger validation and UI updates
      await tester.pumpAndSettle();

      // Verify button is now enabled and tap it
      final continueButton = find.widgetWithText(AppButton, 'Continue');
      expect(tester.widget<AppButton>(continueButton).isDisabled, isFalse);

      await tester.ensureVisible(continueButton);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Assert Navigation happened
      expect(find.text('Delivery Information Screen'), findsOneWidget);

      // Verify that trailing/leading spaces were trimmed before saving to ViewModel
      expect(mockViewModel.savedUser, isNotNull);
      expect(mockViewModel.savedUser!.firstName, 'John');
      expect(mockViewModel.savedUser!.lastName, 'Smith');
      expect(mockViewModel.savedUser!.email, 'john@example.com');
      expect(mockViewModel.savedUser!.phoneNumber, '0987654321');
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
