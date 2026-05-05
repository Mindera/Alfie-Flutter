import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view/address_fields.dart';
import 'package:alfie_flutter/ui/checkout/view/delivery_information_screen.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/checkout_view_model_fake.dart';
import '../../../testing/mocks.dart';

void main() {
  late MockAddress invalidAddress;
  late MockAddress validAddress;
  late MockUserData mockUserData;

  setUpAll(() {
    invalidAddress = MockAddress();
    when(() => invalidAddress.isValid()).thenReturn(false);
    when(() => invalidAddress.country).thenReturn('');
    when(() => invalidAddress.postalCode).thenReturn('');
    when(() => invalidAddress.city).thenReturn('');
    when(() => invalidAddress.street).thenReturn('');
    when(() => invalidAddress.addressLine2).thenReturn(null);

    validAddress = MockAddress();
    when(() => validAddress.isValid()).thenReturn(true);
    when(() => validAddress.country).thenReturn('Portugal');
    when(() => validAddress.postalCode).thenReturn('3000-000');
    when(() => validAddress.city).thenReturn('Coimbra');
    when(() => validAddress.street).thenReturn('Rua da Sofia');
    when(() => validAddress.addressLine2).thenReturn('');

    mockUserData = MockUserData();
  });

  Widget buildTestApp({
    required FakeCheckoutViewModel checkoutViewModel,
    bool startAtHome = false,
    required Key deliveryScreenKey,
  }) {
    final router = GoRouter(
      initialLocation: startAtHome ? '/' : '/delivery',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: ElevatedButton(
              onPressed: () => context.push('/delivery'),
              child: const Text('Go to Delivery'),
            ),
          ),
        ),
        GoRoute(
          path: '/delivery',
          // Included a key here to ensure super.key branch is covered correctly
          builder: (context, state) =>
              DeliveryInformationScreen(key: deliveryScreenKey),
        ),
        GoRoute(
          path: AppRoute.checkout.fullPath,
          builder: (context, state) =>
              const Scaffold(body: Text('Checkout Screen')),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        checkoutViewModelProvider.overrideWith(() => checkoutViewModel),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  group('DeliveryInformationScreen Tests - View Model Integration', () {
    testWidgets(
      'initializes with empty addresses when state has null addresses',
      (tester) async {
        final checkoutViewModel = FakeCheckoutViewModel(
          CheckoutState(
            deliveryAddress: null,
            billingAddress: null,
            userData: mockUserData,
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            checkoutViewModel: checkoutViewModel,
            deliveryScreenKey: const Key('delivery_screen'),
          ),
        );

        // Verify the screen loads and safely initializes using `Address.empty()`
        expect(find.byType(DeliveryInformationScreen), findsOneWidget);
        expect(
          find.byType(AddressFields),
          findsOneWidget,
        ); // Because null == null, checkbox is true
      },
    );

    testWidgets(
      'renders initial UI and disables Continue button when forms are invalid',
      (tester) async {
        final checkoutViewModel = FakeCheckoutViewModel(
          CheckoutState(
            deliveryAddress: invalidAddress,
            billingAddress: invalidAddress,
            userData: mockUserData,
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            checkoutViewModel: checkoutViewModel,
            deliveryScreenKey: const Key('delivery_screen'),
          ),
        );

        expect(find.text('Delivery Indormation'), findsOneWidget);

        // Because delivery and billing instances are the same, checkbox defaults to true showing only 1 form
        expect(find.byType(AddressFields), findsOneWidget);
        expect(find.text('Same as delivery address'), findsOneWidget);

        // Verify the submit button is rendered but disabled
        final continueBtnFinder = find.widgetWithText(AppButton, 'Continue');
        await tester.ensureVisible(continueBtnFinder);

        final continueBtn = tester.widget<AppButton>(continueBtnFinder);
        expect(continueBtn.isDisabled, isTrue);
      },
    );

    testWidgets(
      'shows both address fields initially and submits separate billing address when unchecked',
      (tester) async {
        final anotherValidAddress = MockAddress();
        when(() => anotherValidAddress.isValid()).thenReturn(true);
        when(() => anotherValidAddress.country).thenReturn('Spain');
        when(() => anotherValidAddress.postalCode).thenReturn('28001');
        when(() => anotherValidAddress.city).thenReturn('Madrid');
        when(() => anotherValidAddress.street).thenReturn('Gran Via');
        when(() => anotherValidAddress.addressLine2).thenReturn('');

        final checkoutViewModel = FakeCheckoutViewModel(
          CheckoutState(
            deliveryAddress: validAddress,
            billingAddress: anotherValidAddress,
            userData: mockUserData,
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            checkoutViewModel: checkoutViewModel,
            deliveryScreenKey: const Key('delivery_screen'),
          ),
        );

        // Different instances force the billing checkbox to be false, implicitly revealing 2 forms
        expect(find.byType(AddressFields), findsNWidgets(2));

        // Hit Continue to test the FALSE branch of `billingCheckbox.value ? deliveryAddress.value : billingAddress.value`
        final continueBtnFinder = find.widgetWithText(AppButton, 'Continue');
        await tester.ensureVisible(continueBtnFinder);
        await tester.tap(continueBtnFinder);
        await tester.pumpAndSettle();

        expect(checkoutViewModel.setDeliveryAddressArg, equals(validAddress));
        expect(
          checkoutViewModel.setBillingAddressArg,
          equals(anotherValidAddress),
        );
      },
    );

    testWidgets(
      'handles onChanged callbacks for delivery and billing addresses correctly',
      (tester) async {
        final checkoutViewModel = FakeCheckoutViewModel(
          CheckoutState(
            deliveryAddress: validAddress,
            billingAddress: validAddress,
            userData: mockUserData,
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            checkoutViewModel: checkoutViewModel,
            deliveryScreenKey: const Key('delivery_screen'),
          ),
        );

        // Uncheck "Same as delivery" to mount the second set of form fields
        final checkboxFinder = find.text('Same as delivery address');
        await tester.ensureVisible(checkboxFinder);
        await tester.tap(checkboxFinder);
        await tester.pumpAndSettle();

        final addressFields = tester
            .widgetList<AddressFields>(find.byType(AddressFields))
            .toList();
        expect(addressFields.length, 2);

        // Trigger onChanged externally with FULLY stubbed mocks
        final newDelivery = MockAddress();
        when(() => newDelivery.isValid()).thenReturn(true);
        when(() => newDelivery.country).thenReturn('France');
        when(() => newDelivery.postalCode).thenReturn('75001');
        when(() => newDelivery.city).thenReturn('Paris');
        when(() => newDelivery.street).thenReturn('Rue de Rivoli');
        when(() => newDelivery.addressLine2).thenReturn('');

        final newBilling = MockAddress();
        when(() => newBilling.isValid()).thenReturn(true);
        when(() => newBilling.country).thenReturn('Italy');
        when(() => newBilling.postalCode).thenReturn('00100');
        when(() => newBilling.city).thenReturn('Rome');
        when(() => newBilling.street).thenReturn('Via del Corso');
        when(() => newBilling.addressLine2).thenReturn('');

        addressFields.first.onChanged(newDelivery);
        addressFields.last.onChanged(newBilling);

        await tester.pumpAndSettle();

        // Submit form to verify new values were saved back into the widget's internal hook state
        final continueBtnFinder = find.widgetWithText(AppButton, 'Continue');
        await tester.ensureVisible(continueBtnFinder);
        await tester.tap(continueBtnFinder);
        await tester.pumpAndSettle();

        expect(checkoutViewModel.setDeliveryAddressArg, equals(newDelivery));
        expect(checkoutViewModel.setBillingAddressArg, equals(newBilling));
      },
    );

    testWidgets('toggles billing address fields when checkbox is tapped', (
      tester,
    ) async {
      final checkoutViewModel = FakeCheckoutViewModel(
        CheckoutState(
          deliveryAddress: validAddress,
          billingAddress: validAddress,
          userData: mockUserData,
        ),
      );

      await tester.pumpWidget(
        buildTestApp(
          checkoutViewModel: checkoutViewModel,
          deliveryScreenKey: const Key('delivery_screen'),
        ),
      );

      expect(find.byType(AddressFields), findsOneWidget);

      final checkboxFinder = find.text('Same as delivery address');

      await tester.ensureVisible(checkboxFinder);
      await tester.pumpAndSettle();

      // Tap to Uncheck
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();
      expect(find.byType(AddressFields), findsNWidgets(2));

      // Tap to Re-check
      await tester.ensureVisible(checkboxFinder);
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();
      expect(find.byType(AddressFields), findsOneWidget);
    });

    testWidgets(
      'enables Continue button, updates view model, and navigates when valid form is submitted',
      (tester) async {
        final checkoutViewModel = FakeCheckoutViewModel(
          CheckoutState(
            deliveryAddress: validAddress,
            billingAddress: validAddress,
            userData: mockUserData,
          ),
        );

        await tester.pumpWidget(
          buildTestApp(
            checkoutViewModel: checkoutViewModel,
            deliveryScreenKey: const Key('delivery_screen'),
          ),
        );

        final continueBtnFinder = find.widgetWithText(AppButton, 'Continue');

        await tester.ensureVisible(continueBtnFinder);
        await tester.pumpAndSettle();

        final continueBtn = tester.widget<AppButton>(continueBtnFinder);

        expect(continueBtn.isDisabled, isFalse);

        await tester.tap(continueBtnFinder);
        await tester.pumpAndSettle();

        // Verifies TRUE branch of `billingCheckbox.value ? deliveryAddress.value : billingAddress.value`
        expect(checkoutViewModel.setDeliveryAddressArg, equals(validAddress));
        expect(checkoutViewModel.setBillingAddressArg, equals(validAddress));
        expect(checkoutViewModel.continueAsGuestCalled, isTrue);

        expect(find.text('Checkout Screen'), findsOneWidget);
      },
    );

    testWidgets('navigates back when back button is tapped', (tester) async {
      final checkoutViewModel = FakeCheckoutViewModel(
        CheckoutState(
          deliveryAddress: validAddress,
          billingAddress: validAddress,
          userData: mockUserData,
        ),
      );

      await tester.pumpWidget(
        buildTestApp(
          checkoutViewModel: checkoutViewModel,
          deliveryScreenKey: const Key('delivery_screen'),
          startAtHome: true,
        ),
      );

      await tester.tap(find.text('Go to Delivery'));
      await tester.pumpAndSettle();

      expect(find.text('Delivery Indormation'), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(find.text('Go to Delivery'), findsOneWidget);
    });
  });
}
