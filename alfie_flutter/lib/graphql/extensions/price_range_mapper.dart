import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/graphql/extensions/money_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_range_fragment.graphql.dart';

extension PriceRangeMapper on Fragment$PriceRangeFragment {
  PriceRange toDomain() {
    return PriceRange(low: low.toDomain(), high: high?.toDomain());
  }
}
