import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/graphql/extensions/suggestion_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/media_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_keyword_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_product_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Suggestion Brand Mapper Tests -', () {
    test('should map a List of Suggestion Brand Fragments to domain', () {
      final fragments = [
        Fragment$SuggestionBrandFragment(value: 'Nike', results: 10, slug: ''),
        Fragment$SuggestionBrandFragment(value: 'Adidas', results: 5, slug: ''),
      ];

      final result = fragments.toDomain();

      expect(result.length, 2);
      expect(result[0].value, 'Nike');
      expect(result[0].results, 10);
      expect(result[1].value, 'Adidas');
      expect(result[1].results, 5);
    });
  });

  group('Suggestion Keyword Mapper Tests', () {
    test('should map a List of Suggestion Keyword Fragments  to domain', () {
      final fragments = [
        Fragment$SuggestionKeywordFragment(value: 'Shoes', results: 100),
      ];

      final result = fragments.toDomain();

      expect(result.length, 1);
      expect(result[0].value, 'Shoes');
      expect(result[0].results, 100);
    });
  });

  group('Suggestion Product Mapper Tests - ', () {
    test('should map a List of Suggestion Product Fragments to domain', () {
      final fragments = [
        Fragment$SuggestionProductFragment(
          id: 'prod_1',
          name: 'Running Shoe',
          brandName: 'Nike',
          media: [Fragment$MediaFragment($__typename: 'Media Type')],
          price: Fragment$PriceFragment(
            amount: Fragment$MoneyFragment(
              amount: 12000,
              currencyCode: 'USD',
              amountFormatted: r'$120.00',
            ),
          ),
          slug: '',
        ),
      ];

      final result = fragments.toDomain();

      expect(result.length, 1);
      expect(result[0].id, 'prod_1');
      expect(result[0].name, 'Running Shoe');
      expect(result[0].brandName, 'Nike');
      expect(result[0].media, isA<List<Media>>());
      expect(result[0].price.amount.amount, 120.00);
    });
  });

  group('Suggestion Mapper Tests -', () {
    test('should map a query Suggestion to domain', () {
      final fragment = Query$GetSuggestions$suggestion(
        brands: [
          Fragment$SuggestionBrandFragment(
            value: 'Brand',
            results: 1,
            slug: '',
          ),
        ],
        keywords: [
          Fragment$SuggestionKeywordFragment(value: 'Key', results: 2),
        ],
        products: [],
      );

      final result = fragment.toDomain();

      expect(result.brands.length, 1);
      expect(result.keywords.length, 1);
      expect(result.products, isEmpty);
      expect(result.brands.first.value, 'Brand');
      expect(result.keywords.first.value, 'Key');
    });
  });
}
