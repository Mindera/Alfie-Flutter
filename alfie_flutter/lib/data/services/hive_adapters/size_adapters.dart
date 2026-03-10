import 'package:alfie_flutter/data/models/size.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [SizeGuide].
class SizeGuideAdapter extends TypeAdapter<SizeGuide> {
  @override
  final int typeId = 10;

  @override
  SizeGuide read(BinaryReader reader) {
    return SizeGuide(
      id: reader.readString(),
      name: reader.readString(),
      description: reader.read() as String?,
      sizes: (reader.read() as List).cast<ProductSize>(),
    );
  }

  @override
  void write(BinaryWriter writer, SizeGuide obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.description);
    writer.write(obj.sizes);
  }
}

/// A Hive [TypeAdapter] that handles binary serialization for [ProductSize].
class ProductSizeAdapter extends TypeAdapter<ProductSize> {
  @override
  final int typeId = 11;

  @override
  ProductSize read(BinaryReader reader) {
    return ProductSize(
      id: reader.readString(),
      value: reader.readString(),
      scale: reader.read() as String?,
      description: reader.read() as String?,
      sizeGuide: reader.read() as SizeGuide?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSize obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.value);
    writer.write(obj.scale);
    writer.write(obj.description);
    writer.write(obj.sizeGuide);
  }
}
