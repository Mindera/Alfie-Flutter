import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/graphql/extensions/price_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Price Mapper Tests - ", () {
    test("should map a Price Fragment to domain Price model", () {
      final amount = Fragment$MoneyFragment(
        amount: 2550,
        currencyCode: 'USD',
        amountFormatted: r'$25.50',
      );
      final previous = Fragment$MoneyFragment(
        amount: 3999,
        currencyCode: 'USD',
        amountFormatted: r'$39.99',
      );
      final priceFragment = Fragment$PriceFragment(
        amount: amount,
        was: previous,
      );

      final result = priceFragment.toDomain();

      expect(result.amount, isA<Money>());
      expect(result.previousAmount, isA<Money>());
    });

    test(
      "should map a Price Fragment to domain Price model with null previous",
      () {
        final amount = Fragment$MoneyFragment(
          amount: 2550,
          currencyCode: 'USD',
          amountFormatted: r'$25.50',
        );
        final priceFragment = Fragment$PriceFragment(amount: amount);

        final result = priceFragment.toDomain();

        expect(result.amount, isA<Money>());
        expect(result.previousAmount, isNull);
      },
    );
  });
}
