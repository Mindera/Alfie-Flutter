import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/graphql/extensions/attributes_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/price_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/size_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/variant_fragment.graphql.dart';

/// Converts a GraphQL Product Variant into a domain model.
extension ProductVariantMapper on Fragment$VariantFragment {
  /// Converts this GraphQL product variant to a [ProductVariant]
  /// domain model, delegating to specialized mappers for nested objects.
  ProductVariant toDomain() {
    return ProductVariant(
      sku: sku,
      size: size?.toDomain(),
      colorId: colour?.id,
      attributes: attributes.toDomain(),
      stock: stock,
      price: price.toDomain(),
    );
  }
}
