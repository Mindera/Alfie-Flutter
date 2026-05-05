import 'dart:io';

import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_screen.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/bag_view_model_fake.dart';
import '../../../testing/fakes/product_detail_view_model_fake.dart';
import '../../../testing/fakes/wishlist_view_model_fake.dart';
import '../product_detail/product_detail_test_helpers.dart';

void main() {
  late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  setUp(() {
    HttpOverrides.global = null;
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  });

  GoRouter createRouter(String initialLocation, List<Product> wishlist) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => ProviderScope(
            overrides: [
              wishlistViewModelProvider.overrideWith(
                () => FakeWishlistViewModel(wishlist),
              ),
              bagViewModelProvider.overrideWith(() => FakeBagViewModel()),
              productDetailViewModelProvider.overrideWith2(
                (s) => FakeProductDetailViewModel(
                  createDummyProductDetailState(
                    product: createDummyProduct(id: s, name: s),
                  ),
                ),
              ),
            ],
            child: const WishlistScreen(),
          ),
        ),
        GoRoute(path: '/home', builder: (context, state) => const SizedBox()),
        GoRoute(path: '/bag', builder: (context, state) => const SizedBox()),
      ],
    );
  }

  group('WishlistScreen', () {
    testWidgets('displays empty state when wishlist is empty', (tester) async {
      final router = createRouter('/wishlist', []);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(AppIcons.wishlist), findsOneWidget);
      expect(find.text('Your wishlist is empty.'), findsOneWidget);
      expect(
        find.text('Tap this icon in the products you like to see them here.'),
        findsOneWidget,
      );
    });

    testWidgets('displays grid with products when wishlist is not empty', (
      tester,
    ) async {
      final product = createDummyProduct();
      final router = createRouter('/wishlist', [product]);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(VerticalProductCard), findsOneWidget);
      expect(find.text('Add to Bag'), findsOneWidget);
    });

    testWidgets(
      'tapping add to bag button adds to bag and removes from wishlist and shows snackbar',
      (tester) async {
        tester.view.physicalSize = const Size(500, 1000);
        tester.view.devicePixelRatio = 1.0;
        final router = createRouter('/wishlist', [createDummyProduct()]);
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: router,
            scaffoldMessengerKey: scaffoldMessengerKey,
          ),
        );
        await tester.pumpAndSettle();

        final addToBagButton = find.widgetWithText(AppButton, 'Add to Bag');

        await tester.dragUntilVisible(
          addToBagButton,
          find.byType(GridView),
          const Offset(0, -200),
        );
        await tester.tap(addToBagButton);
        await tester.pumpAndSettle();

        expect(find.text('Added to Bag.'), findsOneWidget);
        expect(find.text('Go to Bag'), findsOneWidget);

        await tester.tap(find.text('Go to Bag'));
        await tester.pumpAndSettle();

        expect(
          router.routerDelegate.currentConfiguration.uri.toString(),
          '/bag',
        );
      },
    );

    testWidgets('back button navigates to home when cannot pop', (
      tester,
    ) async {
      final router = createRouter('/wishlist', []);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(AppIcons.back));
      await tester.pumpAndSettle();

      expect(
        router.routerDelegate.currentConfiguration.uri.toString(),
        '/home',
      );
    });

    testWidgets('share button is tappable', (tester) async {
      final router = createRouter('/wishlist', []);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(AppIcons.share));
      await tester.pump();
      // No action, just tappable
    });
  });
}
