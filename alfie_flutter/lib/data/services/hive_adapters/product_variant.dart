import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/models/size.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [ProductVariant].
class ProductVariantAdapter extends TypeAdapter<ProductVariant> {
  @override
  final int typeId = 13;

  @override
  ProductVariant read(BinaryReader reader) {
    return ProductVariant(
      sku: reader.readString(),
      size: reader.read() as ProductSize?,
      colorId: reader.read() as String?,
      attributes: (reader.read() as Map?)?.cast<String, String>(),
      stock: reader.readInt(),
      price: reader.read() as Price,
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariant obj) {
    writer.writeString(obj.sku);
    writer.write(obj.size);
    writer.write(obj.colorId);
    writer.write(obj.attributes);
    writer.writeInt(obj.stock);
    writer.write(obj.price);
  }
}
