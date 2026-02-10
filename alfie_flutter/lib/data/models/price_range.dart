import 'package:alfie_flutter/data/models/money.dart';

class PriceRange {
  final Money low;
  final Money? high;

  PriceRange({required this.low, this.high});
}
