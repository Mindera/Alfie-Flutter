import 'package:alfie_flutter/graphql/extensions/product_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/colour_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/product_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/variant_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_range_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product Mapper Tests -", () {
    test(
      "should map a Product Fragment to a domain Product model with all nested objects",
      () {
        final money = Fragment$MoneyFragment(
          amount: 2550,
          currencyCode: 'USD',
          amountFormatted: r'$25.50',
        );
        final variant = Fragment$VariantFragment(
          sku: 'sku-1',
          stock: 10,
          price: Fragment$PriceFragment(amount: money),
        );
        final productFragment = Fragment$ProductFragment(
          id: 'prod_001',
          styleNumber: 'SN-99',
          name: 'Classic Tee',
          shortDescription: 'A comfortable cotton tee.',
          longDescription: 'Detailed description of the classic cotton tee...',
          brand: Fragment$BrandFragment(id: 'b1', name: 'Alfie', slug: ''),
          priceRange: Fragment$PriceRangeFragment(
            low: Fragment$MoneyFragment(
              amount: 2550,
              currencyCode: 'USD',
              amountFormatted: r'$25.50',
            ),
          ),
          attributes: [],
          defaultVariant: variant,
          variants: [variant],
          colours: [Fragment$ColourFragment(id: 'c1', name: 'Red')],
          slug: '',
        );

        final result = productFragment.toDomain();

        expect(result.id, 'prod_001');
        expect(result.styleNumber, 'SN-99');
        expect(result.name, 'Classic Tee');
        expect(result.shortDescription, 'A comfortable cotton tee.');

        expect(result.brand.name, 'Alfie');
        expect(result.defaultVariant.sku, 'sku-1');

        expect(result.variants.length, 1);
        expect(result.variants.first.sku, 'sku-1');
        expect(result.colours?.first.id, 'c1');
      },
    );

    test("should handle null optional fields", () {
      final money = Fragment$MoneyFragment(
        amount: 2550,
        currencyCode: 'USD',
        amountFormatted: r'$25.50',
      );
      final variant = Fragment$VariantFragment(
        sku: 'sku-1',
        stock: 10,
        price: Fragment$PriceFragment(amount: money),
      );
      final productFragment = Fragment$ProductFragment(
        id: 'prod_001',
        styleNumber: 'SN-99',
        name: 'Classic Tee',
        shortDescription: 'A comfortable cotton tee.',
        longDescription: null,
        brand: Fragment$BrandFragment(id: 'b1', name: 'Alfie', slug: ''),
        priceRange: null,
        attributes: [],
        defaultVariant: variant,
        variants: [variant],
        colours: null,
        slug: '',
      );

      final result = productFragment.toDomain();

      expect(result.priceRange, isNull);
      expect(result.colours, isNull);
      expect(result.longDescription, isNull);
    });
  });
}
