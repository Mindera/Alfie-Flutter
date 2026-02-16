import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/graphql/extensions/price_range_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_range_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Price Range Mapper Tests -", () {
    test("should map a Price Range Fragment to a domain Price Range model", () {
      final priceRange = Fragment$PriceRangeFragment(
        low: Fragment$MoneyFragment(
          amount: 2550,
          currencyCode: 'USD',
          amountFormatted: r'$25.50',
        ),
        high: Fragment$MoneyFragment(
          amount: 3999,
          currencyCode: 'USD',
          amountFormatted: r'$39.99',
        ),
      );

      final result = priceRange.toDomain();

      expect(result.low, isA<Money>());
      expect(result.high, isA<Money>());
    });
    test(
      "should map a Price Range Fragment to a domain Price Range model, with null high",
      () {
        final priceRange = Fragment$PriceRangeFragment(
          low: Fragment$MoneyFragment(
            amount: 2550,
            currencyCode: 'USD',
            amountFormatted: r'$25.50',
          ),
        );

        final result = priceRange.toDomain();

        expect(result.low, isA<Money>());
        expect(result.high, isNull);
      },
    );
  });
}
