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
  User continueAsGuestUser(
    UserData userData,
    Address deliveryAddress,
    Address billingAddress,
  ) {
    throw UnimplementedError();
  }

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
}

class FakeCheckoutViewModel extends CheckoutViewModel {
  final CheckoutState _state;
  FakeCheckoutViewModel([this._state = const CheckoutState()]);

  @override
  CheckoutState build() => _state;
}

class FakeAddress extends Fake implements Address {
  final String _addressString;
  FakeAddress(this._addressString);

  @override
  String toString() => _addressString;
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
      'renders actual user delivery & billing addresses and delivery method when provided',
      (WidgetTester tester) async {
        final mockUser = MockUser();

        // Use Fakes instead of Mocks to safely override toString()
        final mockDeliveryAddress = FakeAddress('123 Delivery St');
        final mockBillingAddress = FakeAddress('456 Billing Ave');
        final mockDeliveryMethod = DeliveryMethod.express;

        when(() => mockUser.deliveryAddress).thenReturn(mockDeliveryAddress);
        when(() => mockUser.billingAddress).thenReturn(mockBillingAddress);

        final bagViewModel = FakeBagViewModel(totalPrice: 10.0);
        final checkoutState = CheckoutState(deliveryMethod: mockDeliveryMethod);

        await tester.pumpWidget(
          _buildCheckoutScreen(
            user: mockUser,
            bagViewModel: bagViewModel,
            checkoutState: checkoutState,
            screenKey: key,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('123 Delivery St'), findsOneWidget);
        expect(find.text('456 Billing Ave'), findsOneWidget);

        // Asserting against the actual toString output instead of just 'Express'
        expect(find.text(mockDeliveryMethod.toString()), findsOneWidget);

        // Fallbacks should no longer be present
        expect(find.text('Add a delivery address'), findsNothing);
        expect(find.text('Add a billing address'), findsNothing);
        expect(find.text('Select a delivery method'), findsNothing);
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
