import 'dart:io';
import 'package:alfie_flutter/ui/product_detail/view/product_detail_screen.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
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

  group('ProductDetailScreen Tests -', () {
    testWidgets('displays loading state with Center widget', (
      WidgetTester tester,
    ) async {
      final productId = 'test-product-1';

      await tester.pumpWidget(
        _buildProductDetailScreen(
          productId: productId,
          state: createDummyProductDetailState(isLoading: true),
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
          state: createDummyProductDetailState(hasError: true, error: error),
        ),
      );

      expect(find.byType(Center), findsWidgets);
      expect(find.text('Exception: Test error message'), findsOneWidget);
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
            ],
            child: ProductDetailScreen(id: productId),
          ),
        ),
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}
