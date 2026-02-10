import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';

class Product {
  final String id;

  final String styleNumber;

  final String name;

  final Brand brand;

  final PriceRange? priceRange;

  final String shortDescription;

  final String? longDescription;

  final Map<String, String>? attributes;

  final ProductVariant defaultVariant;

  final List<ProductVariant> variants;

  final List<ProductColor>? colours;

  Product({
    required this.id,
    required this.styleNumber,
    required this.name,
    required this.brand,
    this.priceRange,
    required this.shortDescription,
    this.longDescription,
    this.attributes,
    required this.defaultVariant,
    required this.variants,
    this.colours,
  });
}
