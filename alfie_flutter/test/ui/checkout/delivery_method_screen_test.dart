import 'dart:io';

import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view/delivery_method_screen.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/checkout_view_model_fake.dart';

// --- Fakes ---

class TestCheckoutViewModel extends FakeCheckoutViewModel {
  DeliveryMethod? calledMethod;

  TestCheckoutViewModel([super.initialState]);

  @override
  void setDeliveryMethod(DeliveryMethod method) {
    calledMethod = method;
    super.setDeliveryMethod(method);
  }
}

// --- Test Helper Setup ---

Widget _buildDeliveryMethodApp({
  DeliveryMethod? initialValue,
  required TestCheckoutViewModel viewModel,
}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.push('/delivery-method'),
              child: const Text('Go to Screen'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/delivery-method',
        builder: (context, state) =>
            DeliveryMethodScreen(initialValue: initialValue),
      ),
    ],
  );

  return ProviderScope(
    overrides: [checkoutViewModelProvider.overrideWith(() => viewModel)],
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _navigateToScreen(WidgetTester tester) async {
  await tester.tap(find.text('Go to Screen'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() {
    // Required to prevent NetworkImage load errors during testing
    HttpOverrides.global = null;
  });

  group('DeliveryMethodScreen UI & Interaction Tests -', () {
    testWidgets(
      'renders correctly and Continue button is disabled when initialValue is null',
      (WidgetTester tester) async {
        final fakeViewModel = TestCheckoutViewModel();
        await tester.pumpWidget(
          _buildDeliveryMethodApp(viewModel: fakeViewModel),
        );
        await _navigateToScreen(tester);

        // Verify Static UI
        expect(find.text('Delivery Method'), findsOneWidget);
        expect(find.text(DeliveryMethod.standard.label), findsOneWidget);
        expect(find.text(DeliveryMethod.standard.description), findsOneWidget);
        expect(find.text(DeliveryMethod.express.label), findsOneWidget);
        expect(find.text(DeliveryMethod.express.description), findsOneWidget);
        expect(find.text('Continue'), findsOneWidget);

        // Try tapping 'Continue' while disabled
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Ensure we did not pop back and nothing was submitted to the view model
        expect(find.text('Delivery Method'), findsOneWidget);
        expect(fakeViewModel.calledMethod, isNull);
      },
    );

    testWidgets(
      'Continue button is enabled and populates view model when initialValue is provided',
      (WidgetTester tester) async {
        final fakeViewModel = TestCheckoutViewModel();
        await tester.pumpWidget(
          _buildDeliveryMethodApp(
            initialValue: DeliveryMethod.express,
            viewModel: fakeViewModel,
          ),
        );
        await _navigateToScreen(tester);

        // Tap the enabled 'Continue' button
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Ensure navigation fired (screen popped) and view model captured correct state
        expect(find.text('Go to Screen'), findsOneWidget);
        expect(fakeViewModel.calledMethod, DeliveryMethod.express);
      },
    );

    testWidgets(
      'selecting a radio option enables the Continue button and updates view model on tap',
      (WidgetTester tester) async {
        final fakeViewModel = TestCheckoutViewModel();
        await tester.pumpWidget(
          _buildDeliveryMethodApp(viewModel: fakeViewModel),
        );
        await _navigateToScreen(tester);

        // Tap the 'Standard Delivery' radio option
        await tester.tap(find.text(DeliveryMethod.standard.label));
        await tester.pumpAndSettle();

        // Tap the now-enabled 'Continue' button
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Ensure navigation fired (screen popped) and view model captured newly selected state
        expect(find.text('Go to Screen'), findsOneWidget);
        expect(fakeViewModel.calledMethod, DeliveryMethod.standard);
      },
    );

    testWidgets(
      'tapping the back button safely pops the screen without saving',
      (WidgetTester tester) async {
        final fakeViewModel = TestCheckoutViewModel();
        await tester.pumpWidget(
          _buildDeliveryMethodApp(viewModel: fakeViewModel),
        );
        await _navigateToScreen(tester);

        // Tap the App bar back button
        await tester.tap(find.byIcon(AppIcons.back));
        await tester.pumpAndSettle();

        // Ensure navigation popped backward and no state override was fired
        expect(find.text('Go to Screen'), findsOneWidget);
        expect(fakeViewModel.calledMethod, isNull);
      },
    );
  });
}
