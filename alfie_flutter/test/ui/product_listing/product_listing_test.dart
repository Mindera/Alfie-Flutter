import 'dart:io';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_screen.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/dummys.dart';
import '../../../testing/fakes/product_listing_view_model_fale.dart';
import '../../../testing/mocks.dart';

void main() {
  final testCategoryId = ProductListingId(categoryId: "test-category");
  late FakeProductListingViewModel fakeProductListingViewModel;
  late ProductListingState currentState;
  late MockWishlistRepository mockWishlistRepository;
  setUp(() {
    HttpOverrides.global = null;
    mockWishlistRepository = MockWishlistRepository();
    when(() => mockWishlistRepository.getWishlist()).thenReturn([]);

    currentState = ProductListingState(
      params: ProductListingParams(
        categoryId: testCategoryId.categoryId,
        limit: 10,
        offset: 0,
        sort: null,
      ),
      listing: AsyncValue.data(
        ProductListing(
          title: 'Test Category',
          pagination: Pagination(
            total: 2,
            limit: 10,
            offset: 0,
            pages: 10,
            page: 1,
          ),
          products: dummyProducts,
        ),
      ),
      layoutPreference: 2,
    );
  });
  group("Product Listing Tests -", () {
    testWidgets(
      'Tapping 1-column button switches grid layout from 2 to 1 column',
      (WidgetTester tester) async {
        fakeProductListingViewModel = FakeProductListingViewModel(currentState);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              productListingViewModelProvider(
                testCategoryId,
              ).overrideWith(() => fakeProductListingViewModel),
              wishlistRepositoryProvider.overrideWithValue(
                mockWishlistRepository,
              ),
            ],
            child: Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return MaterialApp(
                  theme: theme,
                  home: Scaffold(
                    body: ProductListingScreen(id: testCategoryId),
                  ),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byIcon(AppIcons.grid2Fill), findsOneWidget);
        expect(find.byIcon(AppIcons.grid1), findsOneWidget);

        expect(find.byType(SliverGrid), findsOneWidget);

        _expectColumns(tester, 2);

        // Tap Grid1 Icon
        await tester.tap(find.byIcon(AppIcons.grid1));
        await tester.pumpAndSettle();

        expect(find.byIcon(AppIcons.grid1Fill), findsOneWidget);
        expect(find.byIcon(AppIcons.grid2), findsOneWidget);

        _expectColumns(tester, 1);
      },
    );

    testWidgets(
      'Tapping 2-column button switches grid layout from 1 to 2 column',
      (WidgetTester tester) async {
        fakeProductListingViewModel = FakeProductListingViewModel(
          currentState.copyWith(layoutPreference: 1),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              productListingViewModelProvider(
                testCategoryId,
              ).overrideWith(() => fakeProductListingViewModel),
              wishlistRepositoryProvider.overrideWithValue(
                mockWishlistRepository,
              ),
            ],
            child: Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return MaterialApp(
                  theme: theme,
                  home: Scaffold(
                    body: ProductListingScreen(id: testCategoryId),
                  ),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byIcon(AppIcons.grid1Fill), findsOneWidget);
        expect(find.byIcon(AppIcons.grid2), findsOneWidget);

        expect(find.byType(SliverGrid), findsOneWidget);

        _expectColumns(tester, 1);

        // Tap Grid2 Icon
        await tester.tap(find.byIcon(AppIcons.grid2));
        await tester.pumpAndSettle();

        expect(find.byIcon(AppIcons.grid2Fill), findsOneWidget);
        expect(find.byIcon(AppIcons.grid1), findsOneWidget);

        _expectColumns(tester, 2);
      },
    );
  });
}

void _expectColumns(WidgetTester tester, int count) {
  SliverGrid grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
  SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
  expect(gridDelegate.crossAxisCount, count);
}
