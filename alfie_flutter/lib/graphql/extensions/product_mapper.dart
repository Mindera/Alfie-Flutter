import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/graphql/extensions/attributes_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/brand_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/price_range_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_color_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_variant_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/fragments/product_fragment.graphql.dart';

extension ProductMapper on Fragment$ProductFragment {
  Product toDomain() {
    return Product(
      id: id,
      styleNumber: styleNumber,
      name: name,
      brand: brand.toDomain(),
      priceRange: priceRange?.toDomain(),
      shortDescription: shortDescription,
      longDescription: longDescription,
      attributes: attributes.toDomain(),
      defaultVariant: defaultVariant.toDomain(),
      variants: variants.map((e) => e.toDomain()).toList(),
      colours: colours?.map((e) => e.toDomain()).toList(),
    );
  }
}
