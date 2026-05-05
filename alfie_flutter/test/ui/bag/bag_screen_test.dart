import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view/bag_screen.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/horizontal_product_card.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/quantity_selector_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/fakes/bag_view_model_fake.dart';
import '../../../testing/mocks.dart';

MockBagItem _createValidMockBagItem() {
  final mockBrand = MockBrand();
  when(() => mockBrand.name).thenReturn('Test Brand');

  final mockMoney = MockMoney();
  when(() => mockMoney.formatted).thenReturn(r'$99.99');

  final mockPrice = MockPrice();
  when(() => mockPrice.amount).thenReturn(mockMoney);

  final mockSize = MockProductSize();
  when(() => mockSize.value).thenReturn('M');

  final mockVariant = MockProductVariant();
  when(() => mockVariant.price).thenReturn(mockPrice);
  when(() => mockVariant.size).thenReturn(mockSize);

  final mockMedia = MockMedia();
  when(() => mockMedia.firstUrl).thenReturn('https://example.com/image.png');

  final mockColor = MockProductColor();
  when(() => mockColor.name).thenReturn('Black');
  when(() => mockColor.media).thenReturn([mockMedia]);

  final mockProduct = MockProduct();
  when(() => mockProduct.id).thenReturn('test-id');
  when(() => mockProduct.name).thenReturn('test product');
  when(() => mockProduct.brand).thenReturn(mockBrand);
  when(() => mockProduct.defaultVariant).thenReturn(mockVariant);
  when(() => mockProduct.colours).thenReturn([mockColor]);

  final mockBagItem = MockBagItem();
  when(() => mockBagItem.product).thenReturn(mockProduct);
  when(() => mockBagItem.quantity).thenReturn(1);

  return mockBagItem;
}

Widget _buildBagScreenApp(FakeBagViewModel fakeViewModel) {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: const BagScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.home.fullPath,
        builder: (context, state) => const Scaffold(body: Text('Home Page')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      bagViewModelProvider.overrideWith(() => fakeViewModel),
      scaffoldMessengerKeyProvider.overrideWithValue(scaffoldMessengerKey),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('BagScreen Widget Tests - State Rendering', () {
    testWidgets('renders empty state correctly when no items in bag', (
      tester,
    ) async {
      final fakeViewModel = FakeBagViewModel(items: []);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      expect(find.text("Your bag is empty."), findsOneWidget);
      expect(find.byIcon(AppIcons.bag), findsOneWidget);

      // Bottom Bar (Total & Continue) should not be visible
      expect(find.text('Total'), findsNothing);
      expect(find.text('Continue'), findsNothing);
    });

    testWidgets('renders list and bottom bar when items are in bag', (
      tester,
    ) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(
        items: [mockBagItem],
        totalPrice: 150.75,
      );

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      expect(find.byType(HorizontalProductCard), findsOneWidget);
      expect(find.text("Your bag is empty."), findsNothing);

      // Bottom Bar Verification
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('\$150.75'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets(
      'renders list with separator and bottom bar when multiple items are in bag',
      (tester) async {
        // Create two distinct items with different IDs to prevent ValueKey collisions
        final mockBagItem1 = _createValidMockBagItem();
        final mockBagItem2 = _createValidMockBagItem();

        final fakeViewModel = FakeBagViewModel(
          items: [mockBagItem1, mockBagItem2],
          totalPrice: 150.75,
        );

        await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

        // Verifying 2 widgets proves the ListView.separated built both items and the separator
        expect(find.byType(HorizontalProductCard), findsNWidgets(2));
        expect(find.text("Your bag is empty."), findsNothing);

        // Bottom Bar Verification
        expect(find.text('Total'), findsOneWidget);
        expect(find.text('\$150.75'), findsOneWidget);
        expect(find.text('Continue'), findsOneWidget);
      },
    );
  });

  group('BagScreen Widget Tests - Interactions', () {
    testWidgets('back button triggers navigation', (tester) async {
      final fakeViewModel = FakeBagViewModel(items: []);
      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('onDismiss removes item and SnackBar Undo action restores item', (
      tester,
    ) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      // Trigger the onDismiss callback directly
      final cardWidget = tester.widget<HorizontalProductCard>(
        find.byType(HorizontalProductCard),
      );
      cardWidget.onDismiss?.call(mockBagItem);

      // Pump slightly to start and settle the SnackBar enter animation (avoid pumpAndSettle which waits for hide timer)
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(fakeViewModel.removeItemCalled, isTrue);
      expect(find.text('Removed.'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);

      // Tap Undo
      await tester.tap(find.text('Undo'));
      await tester.pump();

      expect(fakeViewModel.addItemCalled, isTrue);
    });

    testWidgets(
      'onSave adds to wishlist, removes item, and SnackBar Undo action reverts',
      (tester) async {
        final mockBagItem = _createValidMockBagItem();
        final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

        await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

        // Trigger the onSave callback directly
        final cardWidget = tester.widget<HorizontalProductCard>(
          find.byType(HorizontalProductCard),
        );
        cardWidget.onSave?.call(mockBagItem);

        // Pump slightly to start and settle the SnackBar enter animation
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(fakeViewModel.addToWishlistCalled, isTrue);
        expect(fakeViewModel.removeItemCalled, isTrue);
        expect(find.text('Added to Wishlist.'), findsOneWidget);
        expect(find.text('Undo'), findsOneWidget);

        // Tap Undo
        await tester.tap(find.text('Undo'));
        await tester.pump();

        expect(fakeViewModel.removeFromWishlistCalled, isTrue);
        expect(fakeViewModel.addItemCalled, isTrue);
      },
    );
  });

  group('BagScreen Widget Tests - Quantity Selector Modal', () {
    testWidgets('tapping chevron opens quantity modal', (tester) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      // Open the modal
      await tester.tap(find.byIcon(AppIcons.chevronDown));
      await tester.pumpAndSettle();

      expect(find.byType(QuantitySelectorModal), findsOneWidget);
      expect(find.text('Quantity'), findsWidgets);
    });

    testWidgets('tapping add button increases quantity', (tester) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      // Open modal
      await tester.tap(find.byIcon(AppIcons.chevronDown));
      await tester.pumpAndSettle();

      // Tap add (+) button
      await tester.tap(find.byIcon(AppIcons.add));
      await tester.pump();

      expect(fakeViewModel.updateItemQuantityCalled, isTrue);
      // MockBagItem initializes with quantity 1, so 1 + 1 = 2
      expect(fakeViewModel.updatedQuantity, 2);
    });

    testWidgets('tapping minus button decreases quantity', (tester) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      // Open modal
      await tester.tap(find.byIcon(AppIcons.chevronDown));
      await tester.pumpAndSettle();

      // Tap minus (-) button
      await tester.tap(find.byIcon(AppIcons.minus));
      await tester.pump();

      expect(fakeViewModel.updateItemQuantityCalled, isTrue);
      // MockBagItem initializes with quantity 1, so 1 - 1 = 0
      expect(fakeViewModel.updatedQuantity, 0);
    });

    testWidgets('entering valid text updates quantity', (tester) async {
      final mockBagItem = _createValidMockBagItem();
      final fakeViewModel = FakeBagViewModel(items: [mockBagItem]);

      await tester.pumpWidget(_buildBagScreenApp(fakeViewModel));

      // Open modal
      await tester.tap(find.byIcon(AppIcons.chevronDown));
      await tester.pumpAndSettle();

      // Enter a valid number into the TextField
      await tester.enterText(find.byType(TextField), '5');
      await tester.pump();

      expect(fakeViewModel.updateItemQuantityCalled, isTrue);
      expect(fakeViewModel.updatedQuantity, 5);
    });
  });
}
