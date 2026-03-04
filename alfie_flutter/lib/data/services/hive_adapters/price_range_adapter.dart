import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [PriceRange].
class PriceRangeAdapter extends TypeAdapter<PriceRange> {
  @override
  final int typeId = 3;

  @override
  PriceRange read(BinaryReader reader) {
    return PriceRange(
      low: reader.read() as Money,
      high: reader.read() as Money?,
    );
  }

  @override
  void write(BinaryWriter writer, PriceRange obj) {
    writer.write(obj.low);
    writer.write(obj.high);
  }
}
