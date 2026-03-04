import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [Product].
///
/// This allows the repository to persist complete product catalog items directly
/// to local storage.
class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 14;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.readString(),
      styleNumber: reader.readString(),
      name: reader.readString(),
      brand: reader.read() as Brand,
      priceRange: reader.read() as PriceRange?,
      shortDescription: reader.readString(),
      longDescription: reader.read() as String?,
      attributes: (reader.read() as Map?)?.cast<String, String>(),
      defaultVariant: reader.read() as ProductVariant,
      variants: (reader.read() as List).cast<ProductVariant>(),
      colours: (reader.read() as List?)?.cast<ProductColor>(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.styleNumber);
    writer.writeString(obj.name);
    writer.write(obj.brand);
    writer.write(obj.priceRange);
    writer.writeString(obj.shortDescription);
    writer.write(obj.longDescription);
    writer.write(obj.attributes);
    writer.write(obj.defaultVariant);
    writer.write(obj.variants);
    writer.write(obj.colours);
  }
}
