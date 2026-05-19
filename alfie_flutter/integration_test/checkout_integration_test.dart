import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/main.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:integration_test/integration_test.dart';

import '../testing/dummys.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Checkout Feature Integration Tests', () {
    late ProviderContainer container;

    setUp(() async {
      // Initialize Hive for GraphQL persistence
      await initHiveForFlutter();

      // Initialize persistent storage service
      container = ProviderContainer();
      final persistentStorageService = container.read(
        persistentStorageServiceProvider,
      );
      await persistentStorageService.init();

      // Clear any existing data
      // Note: Each test uses a fresh container, so no need to clear
      await persistentStorageService.deleteCheckoutState();
      await persistentStorageService.saveBagItems([
        BagItem(product: dummyProducts[0], quantity: 1),
        BagItem(product: dummyProducts[1], quantity: 2),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    Future<BuildContext> getRouterContext(WidgetTester tester) async {
      final scaffoldFinder = find.byType(Scaffold);
      if (scaffoldFinder.evaluate().isNotEmpty) {
        return tester.element(scaffoldFinder.first);
      } else {
        final routerFinder = find.byType(Router);
        if (routerFinder.evaluate().isNotEmpty) {
          return tester.element(routerFinder.first);
        }
      }
      throw Exception('No router context found');
    }

    Future<void> setupAppWithBagItems(WidgetTester tester) async {
      // Pump the app widget
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MainApp()),
      );
      await tester.pumpAndSettle();

      // Navigate to bag screen via the bottom navigation bar
      final bagTab = find.text('Bag');
      expect(bagTab, findsOneWidget);
      await tester.tap(bagTab);
      await tester.pumpAndSettle();
    }

    group('Successful Checkout Flow', () {
      testWidgets('User can proceed through checkout successfully', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Continue from bag into the checkout funnel
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('CONTINUE AS GUEST'));
        await tester.pumpAndSettle();

        // Should be on contact information screen
        expect(find.text('Contact Info'), findsOneWidget);

        // Fill contact information using TextFormField (AppInputField wraps TextFormField)
        await tester.enterText(find.byType(TextFormField).at(0), 'John');
        await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
        await tester.enterText(
          find.byType(TextFormField).at(2),
          'john.doe@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(3), '+1234567890');
        await tester.pumpAndSettle();

        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Continue').first,
        );
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Should be on delivery information screen
        expect(find.text('Delivery Information'), findsOneWidget);

        // Fill delivery address using TextFormField (AppInputField wraps TextFormField)
        await tester.enterText(find.byType(TextFormField).at(0), 'USA');
        await tester.enterText(find.byType(TextFormField).at(1), '12345');
        await tester.enterText(find.byType(TextFormField).at(2), 'New York');
        await tester.enterText(find.byType(TextFormField).at(3), '123 Main St');
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Should be on checkout summary screen
        expect(find.text('Checkout'), findsOneWidget);

        // Navigate to delivery method from checkout
        await tester.tap(find.text('Delivery Method'));
        await tester.pumpAndSettle();

        // Should be on delivery method screen
        expect(find.text('Delivery Method'), findsOneWidget);

        await tester.tap(find.text('Standard Delivery'));
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Payment Method'));
        await tester.pumpAndSettle();

        // Should be on payment method screen
        expect(find.text('Payment'), findsOneWidget);

        // Add new card
        await tester.tap(find.text('Add new card'));
        await tester.pumpAndSettle();

        // Fill card details in modal order using TextFormField
        await tester.enterText(
          find.byType(TextFormField).at(0),
          '4111111111111111',
        );
        await tester.enterText(find.byType(TextFormField).at(1), 'John Doe');
        await tester.enterText(find.byType(TextFormField).at(2), '12/30');
        await tester.enterText(find.byType(TextFormField).at(3), '123');
        await tester.pumpAndSettle();

        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Continue').first,
        );
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Should be back on payment method screen with card added
        expect(find.textContaining('1111'), findsOneWidget);

        // Return to checkout summary with the saved payment method
        await tester.ensureVisible(find.byIcon(AppIcons.back));
        await tester.tap(find.byIcon(AppIcons.back));
        await tester.pumpAndSettle();

        // Should be on checkout screen
        expect(find.text('Checkout'), findsOneWidget);
        expect(find.textContaining('1111'), findsOneWidget);

        // Verify order summary and total
        expect(find.textContaining('\$'), findsWidgets);

        // Place order
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Place Order').first,
        );
        await tester.pumpAndSettle();

        // Should be on order confirmation screen
        expect(find.text('Thank you!'), findsOneWidget);
        expect(find.text('ORDER NUMBER #1A2B3C4D'), findsOneWidget);
      }, tags: ['smoke']);

      testWidgets('Order confirmation screen shows correct details', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Quick navigation to order confirmation
        final checkoutVM = container.read(checkoutViewModelProvider.notifier);

        // Set up complete checkout state
        checkoutVM.startGuestSession();
        checkoutVM.setUserData(
          const UserData(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phoneNumber: '+1234567890',
          ),
        );
        checkoutVM.setDeliveryAddress(
          const Address(
            country: 'USA',
            postalCode: '12345',
            city: 'New York',
            street: '123 Main St',
          ),
        );
        checkoutVM.setBillingAddress(
          const Address(
            country: 'USA',
            postalCode: '12345',
            city: 'New York',
            street: '123 Main St',
          ),
        );
        checkoutVM.setDeliveryMethod(DeliveryMethod.standard);
        checkoutVM.setPaymentMethod(
          const PaymentCard(
            type: PaymentCardType.visa,
            number: '4111111111111111',
            name: 'John Doe',
            month: 12,
            year: 2025,
            cvv: 123,
          ),
        );

        // Navigate to checkout
        GoRouter.of(await getRouterContext(tester)).go(AppRoute.checkout.path);
        await tester.pumpAndSettle();

        // Place order
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Place Order').first,
        );
        await tester.pumpAndSettle();

        // Verify order confirmation
        expect(find.text('Thank you!'), findsOneWidget);
        expect(find.textContaining('ORDER NUMBER'), findsOneWidget);
        expect(find.textContaining('email@email.com'), findsOneWidget);
      }, tags: ['smoke']);
    });

    group('Error Scenarios', () {
      testWidgets('Empty required fields show validation errors', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Navigate to contact information
        GoRouter.of(
          await getRouterContext(tester),
        ).go(AppRoute.contactInformation.fullPath);
        await tester.pumpAndSettle();

        // Try to continue without filling fields
        final contactContinueButton = find
            .widgetWithText(ElevatedButton, 'Continue')
            .first;
        await tester.tap(contactContinueButton);
        await tester.pumpAndSettle();

        // Should still be on contact info screen with invalid form state
        expect(find.text('Contact Info'), findsOneWidget);
        expect(
          tester
              .widget<ElevatedButton>(
                find.widgetWithText(ElevatedButton, 'Continue').first,
              )
              .enabled,
          isFalse,
        );
      });

      testWidgets('Invalid payment details show errors', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Navigate to checkout and quickly get to payment
        final checkoutVM = container.read(checkoutViewModelProvider.notifier);
        checkoutVM.startGuestSession();
        checkoutVM.setUserData(
          const UserData(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phoneNumber: '+1234567890',
          ),
        );
        checkoutVM.setDeliveryAddress(
          const Address(
            country: 'USA',
            postalCode: '12345',
            city: 'New York',
            street: '123 Main St',
          ),
        );
        checkoutVM.setBillingAddress(
          const Address(
            country: 'USA',
            postalCode: '12345',
            city: 'New York',
            street: '123 Main St',
          ),
        );
        checkoutVM.setDeliveryMethod(DeliveryMethod.standard);

        // Navigate to payment method
        GoRouter.of(
          await getRouterContext(tester),
        ).go(AppRoute.paymentMethod.fullPath);
        await tester.pumpAndSettle();

        // Try to add invalid card
        await tester.tap(find.text('Add new card'));
        await tester.pumpAndSettle();

        // Enter invalid card number
        await tester.enterText(find.byType(TextFormField).at(0), '1234');
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.widgetWithText(ElevatedButton, 'Continue').first,
        );
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Should show validation error
        expect(find.text('Card is invalid'), findsOneWidget);
      });

      testWidgets('Submit button disabled when form is invalid', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Navigate to checkout
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Start guest session
        await tester.tap(find.text('CONTINUE AS GUEST'));
        await tester.pumpAndSettle();
        expect(find.text('Contact Info'), findsOneWidget);

        // Check that continue button is disabled initially
        final continueButton = find
            .widgetWithText(ElevatedButton, 'Continue')
            .first;
        expect(tester.widget<ElevatedButton>(continueButton).enabled, isFalse);

        // Fill some fields but not all
        await tester.enterText(
          find.byType(TextFormField).at(2),
          'test@example.com',
        );
        await tester.pumpAndSettle();

        // Button should still be disabled
        expect(tester.widget<ElevatedButton>(continueButton).enabled, isFalse);

        // Fill all required fields
        await tester.enterText(find.byType(TextFormField).at(0), 'John');
        await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
        await tester.enterText(find.byType(TextFormField).at(3), '+1234567890');
        await tester.pumpAndSettle();

        // Button should now be enabled
        expect(tester.widget<ElevatedButton>(continueButton).enabled, isTrue);
      });
    });

    group('Navigation and UI State', () {
      testWidgets('Proper navigation between checkout steps', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Start checkout flow
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
        expect(find.text('Identification'), findsOneWidget);

        // Guest session
        await tester.tap(find.text('CONTINUE AS GUEST'));
        await tester.pumpAndSettle();
        expect(find.text('Contact Info'), findsOneWidget);

        // Back navigation
        await tester.tap(find.byIcon(AppIcons.back));
        await tester.pumpAndSettle();
        expect(find.text('Identification'), findsOneWidget);
      });

      testWidgets('UI state updates correctly during checkout', (
        WidgetTester tester,
      ) async {
        await setupAppWithBagItems(tester);

        // Navigate to checkout
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Start guest session
        await tester.tap(find.text('CONTINUE AS GUEST'));
        await tester.pumpAndSettle();

        // Fill contact info
        await tester.enterText(find.byType(TextFormField).at(0), 'John');
        await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
        await tester.enterText(
          find.byType(TextFormField).at(2),
          'john@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(3), '+1234567890');
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Fill delivery info
        await tester.enterText(find.byType(TextFormField).at(0), 'USA');
        await tester.enterText(find.byType(TextFormField).at(1), '12345');
        await tester.enterText(find.byType(TextFormField).at(2), 'New York');
        await tester.enterText(find.byType(TextFormField).at(3), '123 Main St');
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // Select delivery method
        await tester.tap(find.text('Delivery Method'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Standard Delivery'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Continue').first);
        await tester.pumpAndSettle();

        // On checkout screen, verify state is reflected
        expect(find.text('Ship to'), findsOneWidget);
        expect(find.textContaining('USA'), findsWidgets);
        expect(find.text('Delivery Method'), findsOneWidget);
        expect(find.textContaining('Standard Delivery'), findsOneWidget);
      });
    });
  });
}
