import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [ProductColor].
class ProductColorAdapter extends TypeAdapter<ProductColor> {
  @override
  final int typeId = 12;

  @override
  ProductColor read(BinaryReader reader) {
    return ProductColor(
      id: reader.readString(),
      name: reader.readString(),
      swatch: reader.read() as MediaImage?,
      media: (reader.read() as List?)?.cast<Media>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductColor obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.swatch);
    writer.write(obj.media);
  }
}
