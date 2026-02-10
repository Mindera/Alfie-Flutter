import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/money_fragment.graphql.dart';

extension MoneyMapper on Fragment$MoneyFragment {
  Money toDomain() => Money(
    amount: amount * 100,
    currencyCode: currencyCode,
    formatted: amountFormatted,
  );
}
