import 'dart:io';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/product_detail/view/wishlist_button.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/fakes/product_detail_view_model_fake.dart';
import '../../../testing/mocks.dart';
import 'product_detail_test_helpers.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;

  setUp(() {
    HttpOverrides.global = null;
    mockWishlistRepository = MockWishlistRepository();
    when(() => mockWishlistRepository.getWishlist()).thenReturn([]);
  });

  group('WishlistButton Widget Tests -', () {
    testWidgets('renders with empty icon when not on wishlist', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildWishlistButtonWidget(product: product, isOnWishlist: false),
      );

      expect(find.byIcon(AppIcons.wishlist), findsOneWidget);
      expect(find.byIcon(AppIcons.wishlistFill), findsNothing);
    });

    testWidgets('renders with filled icon when on wishlist', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildWishlistButtonWidget(product: product, isOnWishlist: true),
      );

      expect(find.byIcon(AppIcons.wishlistFill), findsOneWidget);
      expect(find.byIcon(AppIcons.wishlist), findsNothing);
    });
    group('WishlistButton onPressed Tests -', () {
      testWidgets(
        'tapping button when not on wishlist adds to wishlist and shows snackbar',
        (WidgetTester tester) async {
          final product = createDummyProduct();

          await tester.pumpWidget(
            _buildWishlistButtonWidget(product: product, isOnWishlist: false),
          );

          // Initially empty icon
          expect(find.byIcon(AppIcons.wishlist), findsOneWidget);
          expect(find.byIcon(AppIcons.wishlistFill), findsNothing);

          // Tap the button
          await tester.tap(find.byType(WishlistButton));
          await tester.pumpAndSettle();

          // Now filled icon
          expect(find.byIcon(AppIcons.wishlistFill), findsOneWidget);
          expect(find.byIcon(AppIcons.wishlist), findsNothing);

          // Check snackbar
          expect(find.text('Added to Wishlist.'), findsOneWidget);
          expect(find.text('Go to Wishlist'), findsOneWidget);
        },
      );

      testWidgets(
        'tapping button when on wishlist removes from wishlist and shows snackbar',
        (WidgetTester tester) async {
          final product = createDummyProduct();

          await tester.pumpWidget(
            _buildWishlistButtonWidget(product: product, isOnWishlist: true),
          );

          // Initially filled icon
          expect(find.byIcon(AppIcons.wishlistFill), findsOneWidget);
          expect(find.byIcon(AppIcons.wishlist), findsNothing);

          // Tap the button
          await tester.tap(find.byType(WishlistButton));
          await tester.pumpAndSettle();

          // Now empty icon
          expect(find.byIcon(AppIcons.wishlist), findsOneWidget);
          expect(find.byIcon(AppIcons.wishlistFill), findsNothing);

          // Check snackbar
          expect(find.text('Removed from Wishlist.'), findsOneWidget);
          expect(find.text('Undo'), findsOneWidget);

          // Tap snackbar action to undo
          await tester.tap(find.text('Undo'));
          await tester.pumpAndSettle();

          expect(find.byIcon(AppIcons.wishlistFill), findsOneWidget);
          expect(find.byIcon(AppIcons.wishlist), findsNothing);
        },
      );

      testWidgets(
        'tapping Go to Wishlist snackbar action navigates to wishlist',
        (WidgetTester tester) async {
          final product = createDummyProduct();

          await tester.pumpWidget(
            _buildWishlistButtonWidget(product: product, isOnWishlist: false),
          );

          await tester.tap(find.byType(WishlistButton));
          await tester.pumpAndSettle();

          expect(find.text('Go to Wishlist'), findsOneWidget);

          await tester.tap(find.text('Go to Wishlist'));
          await tester.pumpAndSettle();

          expect(find.text('Wishlist page'), findsOneWidget);
        },
      );
    });
  });
}

Widget _buildWishlistButtonWidget({
  required Product product,
  required bool isOnWishlist,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: ProviderScope(
            overrides: [
              productDetailViewModelProvider(product.id).overrideWith(
                () => FakeProductDetailViewModel(
                  createDummyProductDetailState(
                    product: product,
                    isOnWishlist: isOnWishlist,
                  ),
                ),
              ),
              wishlistRepositoryProvider.overrideWithValue(
                MockWishlistRepository(),
              ),
              authRepositoryProvider.overrideWith(
                () => FakeAuthRepository(createDummyUser()),
              ),
            ],
            child: WishlistButton(product: product),
          ),
        ),
      ),
      GoRoute(
        path: AppRoute.wishlist.fullPath,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Wishlist page')),
        ),
      ),
    ],
  );

  return MaterialApp.router(
    routerConfig: router,
  );
}
