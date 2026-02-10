import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/graphql/extensions/money_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_range_fragment.graphql.dart';

/// Converts a GraphQL Price Range into a domain model.
extension PriceRangeMapper on Fragment$PriceRangeFragment {
  /// Converts this GraphQL product to a [PriceRange]
  /// domain model, delegating to specialized mappers for nested objects.
  PriceRange toDomain() {
    return PriceRange(low: low.toDomain(), high: high?.toDomain());
  }
}
