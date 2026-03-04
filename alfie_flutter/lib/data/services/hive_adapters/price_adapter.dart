import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [Price].
class PriceAdapter extends TypeAdapter<Price> {
  @override
  final int typeId = 4;

  @override
  Price read(BinaryReader reader) {
    return Price(
      amount: reader.read() as Money,
      previousAmount: reader.read() as Money?,
    );
  }

  @override
  void write(BinaryWriter writer, Price obj) {
    writer.write(obj.amount);
    writer.write(obj.previousAmount);
  }
}
