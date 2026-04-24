import 'package:alfie_flutter/ui/checkout/view/checkout_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('CheckoutItem Widget Tests -', () {
    testWidgets(
      'renders default fallback message when content and label are null',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestWidget(const CheckoutItem()));

        // Verify the default fallback message is displayed
        expect(find.text('No data'), findsOneWidget);
        // Verify no extra label is displayed (only the fallback text should exist)
        expect(find.byType(Text), findsOneWidget);
        // Verify the trailing chevron icon is displayed
        expect(find.byIcon(AppIcons.chevronRight), findsOneWidget);
      },
    );

    testWidgets('renders label and content correctly when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CheckoutItem(label: 'Delivery', content: '123 Flutter Street'),
        ),
      );

      // Verify the label is displayed
      expect(find.text('Delivery'), findsOneWidget);
      // Verify the content is displayed
      expect(find.text('123 Flutter Street'), findsOneWidget);
      // Verify the fallback message is NOT displayed
      expect(find.text('No data'), findsNothing);
    });

    testWidgets('renders custom fallback message when content is null', (
      WidgetTester tester,
    ) async {
      const customFallback = 'Please select an address';

      await tester.pumpWidget(
        buildTestWidget(
          const CheckoutItem(
            label: 'Billing',
            nullValueFallBackMessage: customFallback,
          ),
        ),
      );

      // Verify the label is displayed
      expect(find.text('Billing'), findsOneWidget);
      // Verify the custom fallback message is displayed
      expect(find.text(customFallback), findsOneWidget);
      // Verify the default fallback is NOT displayed
      expect(find.text('No data'), findsNothing);
    });

    testWidgets('triggers onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      bool isTapped = false;

      await tester.pumpWidget(
        buildTestWidget(
          CheckoutItem(
            label: 'Payment',
            content: 'Visa ****1234',
            onPressed: () {
              isTapped = true;
            },
          ),
        ),
      );

      // Tap the item (using InkWell as the target)
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Verify the callback was executed
      expect(isTapped, isTrue);
    });

    testWidgets('does not crash when tapped and onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CheckoutItem(
            label: 'Payment',
            content: 'Visa ****1234',
            // onPressed is intentionally left null
          ),
        ),
      );

      // Tap the item
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // If the test reaches here without throwing an exception, it passed.
      expect(tester.takeException(), isNull);
    });
  });
}
