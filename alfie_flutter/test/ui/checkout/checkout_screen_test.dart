import 'dart:io';

import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view/checkout_screen.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/fakes/bag_view_model_fake.dart';
import '../../../testing/mocks.dart';

// --- Fakes ---

class FakeAuthRepository extends Notifier<User?> implements AuthRepository {
  final User? _user;
  FakeAuthRepository([this._user]);

  @override
  User? build() => _user;

  @override
  User createAccount(UserData userData) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  bool signIn(String email, String password) {
    throw UnimplementedError();
  }

  @override
  void startGuestSession() {
    throw UnimplementedError();
  }
}

class FakeCheckoutViewModel extends CheckoutViewModel {
  final CheckoutState _state;
  FakeCheckoutViewModel([this._state = const CheckoutState()]);

  @override
  CheckoutState build() => _state;
}

// --- Test Helper Setup ---

Widget _buildCheckoutScreen({
  User? user,
  required FakeBagViewModel bagViewModel,
  CheckoutState checkoutState = const CheckoutState(),
  required Key screenKey,
}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => CheckoutScreen(key: screenKey),
      ),
      GoRoute(
        path: AppRoute.bag.fullPath,
        builder: (context, state) => const Scaffold(body: Text('Bag Screen')),
      ),
      GoRoute(
        path: AppRoute.deliveryInformation.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Text('Delivery Info Screen')),
      ),
      GoRoute(
        path: AppRoute.deliveryMethod.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Text('Delivery Method Screen')),
      ),
      GoRoute(
        path: AppRoute.paymentMethod.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Text('Payment Method Screen')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWith(() => FakeAuthRepository(user)),
      bagViewModelProvider.overrideWith(() => bagViewModel),
      checkoutViewModelProvider.overrideWith(
        () => FakeCheckoutViewModel(checkoutState),
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  late Key key;
  setUpAll(() {
    // Required to prevent NetworkImage load errors during testing
    HttpOverrides.global = null;
    key = const Key("test-key");
  });

  group('CheckoutScreen UI Tests -', () {
    testWidgets(
      'renders all default static sections and total amount correctly',
      (WidgetTester tester) async {
        final bagViewModel = FakeBagViewModel(totalPrice: 150.50);

        await tester.pumpWidget(
          _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
        );
        await tester.pumpAndSettle();

        expect(find.text('Checkout'), findsOneWidget);
        expect(find.text('Ship to'), findsOneWidget);
        expect(find.text('Billing Address'), findsOneWidget);
        expect(find.text('Delivery Method'), findsOneWidget);
        expect(find.text('Payment Method'), findsOneWidget);
        expect(find.text('Add promo code / gift card'), findsOneWidget);

        expect(find.text('Total'), findsOneWidget);
        expect(find.text(r'$150.50'), findsOneWidget);
        expect(find.text('Continue'), findsOneWidget);
      },
    );

    testWidgets(
      'renders fallback placeholder text when user data and state is empty',
      (WidgetTester tester) async {
        final bagViewModel = FakeBagViewModel(totalPrice: 0.0);

        await tester.pumpWidget(
          _buildCheckoutScreen(
            bagViewModel: bagViewModel,
            user: null,
            checkoutState: const CheckoutState(),
            screenKey: key,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Add a delivery address'), findsOneWidget);
        expect(find.text('Add a billing address'), findsOneWidget);
        expect(find.text('Select a delivery method'), findsOneWidget);
        expect(find.text('Add a payment method'), findsOneWidget);
      },
    );

    testWidgets(
      'renders actual user delivery & billing addresses when provided',
      (WidgetTester tester) async {
        final mockUser = MockRegisteredUser();

        // Create valid fake addresses
        final deliveryAddr = Address(
          street: '123 Delivery St',
          city: 'London',
          postalCode: 'E1 6AN',
          country: 'UK',
        );
        final billingAddr = Address(
          street: '456 Billing Ave',
          city: 'London',
          postalCode: 'NW1 4NP',
          country: 'UK',
        );

        // Stub the user to return these addresses
        when(() => mockUser.deliveryAddress).thenReturn(deliveryAddr);
        when(() => mockUser.billingAddress).thenReturn(billingAddr);

        final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

        // CRITICAL: Pass the mockUser into the CheckoutState
        final checkoutState = CheckoutState(
          user:
              mockUser, // This ensures ref.watch(checkoutViewModelProvider) sees the user
          deliveryMethod: DeliveryMethod.standard,
        );

        await tester.pumpWidget(
          _buildCheckoutScreen(
            user: mockUser,
            bagViewModel: bagViewModel,
            checkoutState: checkoutState,
            screenKey: key,
          ),
        );

        await tester.pumpAndSettle();

        // Verify the output of Address.toString()
        expect(find.textContaining('123 Delivery St'), findsOneWidget);
        expect(find.textContaining('456 Billing Ave'), findsOneWidget);

        // Fallbacks should be gone
        expect(find.text('Add a delivery address'), findsNothing);
        expect(find.text('Add a billing address'), findsNothing);
      },
    );
  });

  group('CheckoutScreen Navigation Interaction Tests -', () {
    testWidgets('navigates to bag screen when back button is pressed', (
      WidgetTester tester,
    ) async {
      final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

      await tester.pumpWidget(
        _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(find.text('Bag Screen'), findsOneWidget);
    });

    testWidgets('navigates to delivery information when Ship to is tapped', (
      WidgetTester tester,
    ) async {
      final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

      await tester.pumpWidget(
        _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ship to'));
      await tester.pumpAndSettle();

      expect(find.text('Delivery Info Screen'), findsOneWidget);
    });

    testWidgets(
      'navigates to delivery information when Billing Address is tapped',
      (WidgetTester tester) async {
        final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

        await tester.pumpWidget(
          _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Billing Address'));
        await tester.pumpAndSettle();

        expect(
          find.text('Delivery Info Screen'),
          findsOneWidget,
        ); // Route mapped dynamically in screen
      },
    );

    testWidgets('navigates to delivery method when Delivery Method is tapped', (
      WidgetTester tester,
    ) async {
      final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

      await tester.pumpWidget(
        _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delivery Method'));
      await tester.pumpAndSettle();

      expect(find.text('Delivery Method Screen'), findsOneWidget);
    });

    testWidgets('navigates to payment method when Payment Method is tapped', (
      WidgetTester tester,
    ) async {
      final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

      await tester.pumpWidget(
        _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Payment Method'));
      await tester.pumpAndSettle();

      expect(find.text('Payment Method Screen'), findsOneWidget);
    });

    testWidgets('continue button can be interacted with', (
      WidgetTester tester,
    ) async {
      final bagViewModel = FakeBagViewModel(totalPrice: 10.0);

      await tester.pumpWidget(
        _buildCheckoutScreen(bagViewModel: bagViewModel, screenKey: key),
      );
      await tester.pumpAndSettle();

      // Ensure the continue action button doesn't crash on trigger
      final continueBtn = find.text('Continue');
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
