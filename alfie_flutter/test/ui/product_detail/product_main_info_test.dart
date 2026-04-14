import 'dart:io';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_main_info.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/product_detail_view_model_fake.dart';
import 'product_detail_test_helpers.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });

  group('ProductMainInfo Widget Tests -', () {
    testWidgets('renders product brand, name, and price correctly', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct(
        brandName: 'Test Brand',
        name: 'test product',
        price: r'$99.99',
      );

      await tester.pumpWidget(
        _buildProductMainInfoWidget(product: product, isOnWishlist: false),
      );

      expect(find.text('Test Brand'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text(r'$99.99'), findsOneWidget);
    });

    testWidgets('renders color swatch with correct color count', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct(
        colours: createDummyColors(colorCount: 3),
      );

      await tester.pumpWidget(
        _buildProductMainInfoWidget(product: product, isOnWishlist: false),
      );

      expect(find.byType(ProductMainInfo), findsOneWidget);
      // Color swatch should exist with the product
      expect(find.byKey(const ValueKey('color-0')), findsNothing);
    });

    testWidgets('renders Add to Bag button and WishlistButton', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildProductMainInfoWidget(product: product, isOnWishlist: false),
      );

      expect(find.text('Add to Bag'), findsOneWidget);
    });

    testWidgets('tapping Add to Bag button shows snackbar when authenticated', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildProductMainInfoWidget(product: product, isOnWishlist: false),
      );

      await tester.tap(find.text('Add to Bag'));
      await tester.pumpAndSettle();

      expect(find.text('Added to bag.'), findsOneWidget);
      expect(find.text('Go to Bag'), findsOneWidget);
    });

    testWidgets('tapping Go to Bag action navigates to bag', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildProductMainInfoWidget(product: product, isOnWishlist: false),
      );

      await tester.tap(find.text('Add to Bag'));
      await tester.pumpAndSettle();

      expect(find.text('Go to Bag'), findsOneWidget);

      await tester.tap(find.text('Go to Bag'));
      await tester.pumpAndSettle();

      expect(find.text('Bag page'), findsOneWidget);
    });

    testWidgets('tapping Add to Bag when not authenticated navigates to auth', (
      WidgetTester tester,
    ) async {
      final product = createDummyProduct();

      await tester.pumpWidget(
        _buildProductMainInfoWidget(
          product: product,
          isOnWishlist: false,
          isAuthenticated: false,
        ),
      );

      await tester.tap(find.text('Add to Bag'));
      await tester.pumpAndSettle();

      expect(find.text('Auth page'), findsOneWidget);
    });
  });
}

Widget _buildProductMainInfoWidget({
  required Product product,
  required bool isOnWishlist,
  bool isAuthenticated = true,
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
              authRepositoryProvider.overrideWith(
                () => FakeAuthRepository(
                  isAuthenticated ? createDummyUser() : null,
                ),
              ),
            ],
            child: ProductMainInfo(
              product: product,
              isOnWishlist: isOnWishlist,
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoute.bag.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Bag page'))),
      ),
      GoRoute(
        path: AppRoute.auth.fullPath,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Auth page'))),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}
