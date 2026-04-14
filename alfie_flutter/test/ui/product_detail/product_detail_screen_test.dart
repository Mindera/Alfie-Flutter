import 'dart:io';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_detail_screen.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../testing/fakes/product_detail_view_model_fake.dart';
import '../../../testing/mocks.dart';
import 'product_detail_test_helpers.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });

  group('ProductDetailScreen Tests -', () {
    testWidgets('displays loading state with Center widget', (
      WidgetTester tester,
    ) async {
      final productId = 'test-product-1';

      await tester.pumpWidget(
        _buildProductDetailScreen(
          productId: productId,
          state: createDummyProductDetailState(
            isLoading: true,
            product: createDummyProduct(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('displays error state with error message', (
      WidgetTester tester,
    ) async {
      final productId = 'test-product-1';
      final error = Exception('Test error message');

      await tester.pumpWidget(
        _buildProductDetailScreen(
          productId: productId,
          state: createDummyProductDetailState(
            hasError: true,
            error: error,
            product: createDummyProduct(),
          ),
        ),
      );

      expect(find.byType(Center), findsWidgets);
      expect(find.text('Exception: Test error message'), findsOneWidget);
    });

    testWidgets('displays Not Found when product is null in data state', (
      WidgetTester tester,
    ) async {
      final productId = 'test-product-1';

      await tester.pumpWidget(
        _buildProductDetailScreen(
          productId: productId,
          state: createDummyProductDetailState(product: null),
        ),
      );

      expect(find.text('Not Found'), findsOneWidget);
      expect(find.byType(Center), findsWidgets);
    });
  });
}

Widget _buildProductDetailScreen({
  required String productId,
  required ProductDetailState state,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, routeState) => Scaffold(
          body: ProviderScope(
            overrides: [
              productDetailViewModelProvider(
                productId,
              ).overrideWith(() => FakeProductDetailViewModel(state)),
              authRepositoryProvider.overrideWith(() => MockAuthRepository()),
            ],
            child: ProductDetailScreen(id: productId),
          ),
        ),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}
