import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/size.dart';

class ProductVariant {
  final String sku;

  final ProductSize? size;

  final String? colorId;

  final Map<String, String>? attributes;

  final int stock;

  final Price price;

  ProductVariant({
    required this.sku,
    this.size,
    this.colorId,
    this.attributes,
    required this.stock,
    required this.price,
  });
}
