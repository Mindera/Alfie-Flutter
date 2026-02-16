import 'package:alfie_flutter/graphql/extensions/money_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Money Mapper Tests -", () {
    test(
      "should map a Money Fragment to a domain Money model with correct decimal conversion",
      () {
        final moneyFragment = Fragment$MoneyFragment(
          amount: 2550,
          currencyCode: 'USD',
          amountFormatted: r'$25.50',
        );

        final result = moneyFragment.toDomain();

        expect(result.amount, 25.50);
        expect(result.currencyCode, 'USD');
        expect(result.formatted, r'$25.50');
      },
    );

    test("should handle zero amount correctly", () {
      final moneyFragment = Fragment$MoneyFragment(
        amount: 0,
        currencyCode: 'GBP',
        amountFormatted: '£0.00',
      );

      final result = moneyFragment.toDomain();

      expect(result.amount, 0);
      expect(result.currencyCode, 'GBP');
      expect(result.formatted, '£0.00');
    });
  });
}
