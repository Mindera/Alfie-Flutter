import 'dart:io';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/product_detail/view/wishlist_button.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/fakes/product_detail_view_model_fake.dart';
import '../../../testing/mocks.dart';
import 'product_detail_test_helpers.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;

  setUpAll(() {
    registerFallbackValue(createDummyProduct());
  });

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
  });
}

Widget _buildWishlistButtonWidget({
  required Product product,
  required bool isOnWishlist,
}) {
  return MaterialApp(
    home: Scaffold(
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
        ],
        child: WishlistButton(product: product),
      ),
    ),
  );
}
