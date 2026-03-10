import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [BagItem].
class BagItemAdapter extends TypeAdapter<BagItem> {
  /// The unique identifier for this type within Hive.
  @override
  final int typeId = 15;

  @override
  BagItem read(BinaryReader reader) {
    return BagItem(
      product: reader.read() as Product,
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, BagItem obj) {
    writer.write(obj.product);
    writer.writeInt(obj.quantity);
  }
}
