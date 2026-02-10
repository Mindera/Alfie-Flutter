import 'package:alfie_flutter/data/models/money.dart';

class Price {
  final Money amount;
  final Money? previousAmount;

  Price({required this.amount, this.previousAmount});
}
