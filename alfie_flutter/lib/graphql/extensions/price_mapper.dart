import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/graphql/extensions/money_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';

extension PriceMapper on Fragment$PriceFragment {
  Price toDomain() {
    return Price(amount: amount.toDomain(), previousAmount: was?.toDomain());
  }
}
