import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/graphql/extensions/money_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/price_fragment.graphql.dart';

/// Converts a GraphQL Price into a domain model.
extension PriceMapper on Fragment$PriceFragment {
  /// Converts this GraphQL price to a [Price]
  /// domain model, delegating to specialized mappers for nested objects.
  Price toDomain() {
    return Price(amount: amount.toDomain(), previousAmount: was?.toDomain());
  }
}
