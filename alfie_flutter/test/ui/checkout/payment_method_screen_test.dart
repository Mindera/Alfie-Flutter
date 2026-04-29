import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/checkout/view/add_new_card_modal.dart';
import 'package:alfie_flutter/ui/checkout/view/payment_method_screen.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// A fake ViewModel to capture and verify interactions with the CheckoutViewModel
class FakeCheckoutViewModel extends Notifier<CheckoutState>
    implements CheckoutViewModel {
  final CheckoutState _initialState;
  PaymentCard? capturedPaymentCard;

  FakeCheckoutViewModel([this._initialState = const CheckoutState()]);

  @override
  CheckoutState build() => _initialState;

  @override
  void setPaymentMethod(PaymentCard paymentCard) {
    capturedPaymentCard = paymentCard;
  }

  // No-op overrides to satisfy the CheckoutViewModel interface
  @override
  void applyPromoCode(String code) {}
  @override
  void setBillingAddress(Address billingAddress) {}
  @override
  void setDeliveryAddress(Address deliveryAddress) {}
  @override
  void setDeliveryMethod(DeliveryMethod method) {}
  @override
  void setUserData(UserData userData) {}
  @override
  void startGuestSession() {}
  @override
  void useShippingAsBilling() {}
  @override
  double get totalPrice => 0.0;
}

void main() {
  late FakeCheckoutViewModel viewModel;

  /// Helper to build the widget under test alongside necessary routing and providers
  Widget buildTestApp({
    PaymentCard? initialValue,
    CheckoutState initialState = const CheckoutState(),
  }) {
    viewModel = FakeCheckoutViewModel(initialState);

    final router = GoRouter(
      initialLocation: '/', // Start at the root so we have a stack history
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Column(
              children: [
                const Text('Home Screen'),
                ElevatedButton(
                  onPressed: () => context.push('/payment'),
                  child: const Text('Open Payment'),
                ),
              ],
            ),
          ),
        ),
        GoRoute(
          path: '/payment',
          builder: (context, state) =>
              PaymentMethodScreen(initialValue: initialValue),
        ),
      ],
    );

    return ProviderScope(
      overrides: [checkoutViewModelProvider.overrideWith(() => viewModel)],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  /// Helper function to open the payment screen before running assertions
  Future<void> openPaymentScreen(WidgetTester tester) async {
    await tester.tap(find.text('Open Payment'));
    await tester.pumpAndSettle();
  }

  group('PaymentMethodScreen Widget Tests -', () {
    testWidgets('renders correctly with no available cards', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await openPaymentScreen(tester);

      expect(find.text('Payment'), findsOneWidget);
      expect(find.text('Add new card'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('pops without setting payment method if no card is selected', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestApp());
      await openPaymentScreen(tester);

      // Tap back button
      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      // Verify navigation to home and no setPaymentMethod call
      expect(find.text('Home Screen'), findsOneWidget);
      expect(viewModel.capturedPaymentCard, isNull);
    });

    testWidgets(
      'displays available cards, updates selection, and calls setPaymentMethod on back tap',
      (tester) async {
        const card1 = PaymentCard(
          type: PaymentCardType.visa,
          number: '4111111111114444',
          name: 'John Doe',
          month: 12,
          year: 2026,
          cvv: 123,
        );

        const card2 = PaymentCard(
          type: PaymentCardType.master,
          number: '5555555555558888',
          name: 'Jane Doe',
          month: 11,
          year: 2025,
          cvv: 456,
        );

        final fakeUser = GuestUser(id: 'user-1', paymentCards: [card1, card2]);

        await tester.pumpWidget(
          buildTestApp(
            initialValue: card1,
            initialState: CheckoutState(user: fakeUser),
          ),
        );
        await openPaymentScreen(tester);

        // Verify both cards render as Radio options using their display string format
        expect(find.text(card1.displayString()), findsOneWidget);
        expect(find.text(card2.displayString()), findsOneWidget);

        // Select the second card option
        await tester.tap(find.text(card2.displayString()));
        await tester.pumpAndSettle();

        // Tap back button
        await tester.tap(find.byIcon(AppIcons.back));
        await tester.pumpAndSettle();

        // Verify navigation to home and setPaymentMethod was correctly executed with `card2`
        expect(find.text('Home Screen'), findsOneWidget);
        expect(viewModel.capturedPaymentCard, card2);
        expect(viewModel.capturedPaymentCard?.type, PaymentCardType.master);
      },
    );

    testWidgets('tapping Add new card opens AddNewCardModal', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await openPaymentScreen(tester);

      // Tap the "Add new card" list tile
      await tester.tap(find.text('Add new card'));
      await tester.pumpAndSettle();

      // Verify bottom modal sheet rendered
      expect(find.byType(AddNewCardModal), findsOneWidget);
    });
  });
}
