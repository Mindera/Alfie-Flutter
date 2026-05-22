import 'package:alfie_flutter/data/models/brand.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] for binary serialization of [Brand] entities.
class BrandAdapter extends TypeAdapter<Brand> {
  /// The unique identifier for this type within Hive.
  @override
  final int typeId = 1;

  @override
  Brand read(BinaryReader reader) {
    return Brand(id: reader.readString(), name: reader.readString());
  }

  @override
  void write(BinaryWriter writer, Brand obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
  }
}
