import 'dart:io';
import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_screen.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

final dummyProducts = [
  Product(
    id: "id1",
    styleNumber: "styleNumber1",
    name: "name1",
    brand: Brand(id: "id", name: "brand"),
    shortDescription: "shortDescription",
    defaultVariant: ProductVariant(
      sku: "sku",
      stock: 1,
      price: Price(
        amount: Money(amount: 2550, currencyCode: 'USD', formatted: r'$25.50'),
      ),
    ),
    variants: [
      ProductVariant(
        sku: "sku",
        stock: 1,
        price: Price(
          amount: Money(
            amount: 2550,
            currencyCode: 'USD',
            formatted: r'$25.50',
          ),
        ),
      ),
    ],
    colours: [
      ProductColor(
        id: "id",
        name: "color",
        media: [
          MediaImage(
                url:
                    'https://images.pexels.com/photos/35255594/pexels-photo-35255594.jpeg',
              )
              as Media,
        ],
      ),
    ],
  ),
  Product(
    id: "id2",
    styleNumber: "styleNumber2",
    name: "name2",
    brand: Brand(id: "id", name: "brand"),
    shortDescription: "shortDescription",
    defaultVariant: ProductVariant(
      sku: "sku",
      stock: 1,
      price: Price(
        amount: Money(amount: 2550, currencyCode: 'USD', formatted: r'$25.50'),
      ),
    ),
    variants: [
      ProductVariant(
        sku: "sku",
        stock: 1,
        price: Price(
          amount: Money(
            amount: 2550,
            currencyCode: 'USD',
            formatted: r'$25.50',
          ),
        ),
      ),
    ],
    colours: [
      ProductColor(
        id: "id",
        name: "color",
        media: [
          MediaImage(
                url:
                    'https://images.pexels.com/photos/35255594/pexels-photo-35255594.jpeg',
              )
              as Media,
        ],
      ),
    ],
  ),
];

void main() {
  const testCategoryId = 'test-category-123';
  late MockProductListingViewModel mockViewModel;
  setUp(() {
    HttpOverrides.global = null;
    mockViewModel = MockProductListingViewModel();

    when(() => mockViewModel.build()).thenAnswer(
      (_) async => ProductListingState(
        params: ProductListingParams(
          categoryId: testCategoryId,
          limit: 10,
          offset: 0,
          sort: null,
        ),
        listing: ProductListing(
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
    );
  });
  group("Product Listing Tests -", () {
    testWidgets(
      'Tapping 1-column button switches grid layout from 2 to 1 column',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              productListingViewModelProvider(
                testCategoryId,
              ).overrideWith(() => mockViewModel),
            ],
            child: Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return MaterialApp(
                  theme: theme,
                  home: const Scaffold(
                    body: ProductListingScreen(categoryId: testCategoryId),
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
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              productListingViewModelProvider(
                testCategoryId,
              ).overrideWith(() => mockViewModel),
            ],
            child: Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return MaterialApp(
                  theme: theme,
                  home: const Scaffold(
                    body: ProductListingScreen(
                      categoryId: testCategoryId,
                      initialColumns: 1,
                    ),
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
