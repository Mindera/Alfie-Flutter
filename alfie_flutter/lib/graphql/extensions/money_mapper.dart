import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';

/// Converts a GraphQL Money into a domain model.
extension MoneyMapper on Fragment$MoneyFragment {
  /// Converts this money fragment to a [Money] domain model.
  Money toDomain() => Money(
    amount: amount * 100,
    currencyCode: currencyCode,
    formatted: amountFormatted,
  );
}
