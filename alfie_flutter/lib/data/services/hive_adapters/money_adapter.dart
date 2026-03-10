import 'package:alfie_flutter/data/models/money.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [Money].
class MoneyAdapter extends TypeAdapter<Money> {
  @override
  final int typeId = 2;

  @override
  Money read(BinaryReader reader) {
    return Money(
      currencyCode: reader.readString(),
      amount: reader.readDouble(),
      formatted: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Money obj) {
    writer.writeString(obj.currencyCode);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.formatted);
  }
}
