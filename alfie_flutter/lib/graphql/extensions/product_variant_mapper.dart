import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/graphql/extensions/attributes_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/price_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/size_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/variant_fragment.graphql.dart';

extension ProductVariantMapper on Fragment$VariantFragment {
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
