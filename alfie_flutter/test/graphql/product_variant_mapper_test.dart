import 'package:alfie_flutter/graphql/extensions/product_variant_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/attributes_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/size_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/variant_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product Variant Mapper Tests -", () {
    test(
      "should map a Product Variant Fragment to a domain Product Variant model",
      () {
        final productVariantFragment = Fragment$VariantFragment(
          sku: 'sku',
          size: Fragment$SizeTreeFragment(id: "1", value: "M"),
          colour: Fragment$VariantFragment$colour(id: "colorId"),
          attributes: List<Fragment$AttributesFragment>.empty(),
          stock: 10,
          price: Fragment$PriceFragment(
            amount: Fragment$MoneyFragment(
              currencyCode: "USD",
              amount: 2000,
              amountFormatted: r"$20.00",
            ),
          ),
        );

        final result = productVariantFragment.toDomain();

        expect(result.sku, 'sku');
        expect(result.size?.id, "1");
        expect(result.size?.value, "M");
        expect(result.colorId, 'colorId');
        expect(result.attributes, <String, String>{});
        expect(result.stock, 10);
        expect(result.price.amount.currencyCode, "USD");
        expect(result.price.amount.amount, 20);
        expect(result.price.amount.formatted, r"$20.00");
      },
    );
  });
}
