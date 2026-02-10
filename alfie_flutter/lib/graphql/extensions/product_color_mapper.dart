import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/graphql/extensions/media_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/colour_fragment.graphql.dart';

/// Converts a GraphQL Color into a domain model.
extension ProductColorMapper on Fragment$ColourFragment {
  /// Converts this GraphQL color to a [ProductColor]
  /// domain model, delegating to specialized mappers for nested objects.
  ProductColor toDomain() {
    return ProductColor(
      id: id,
      name: name,
      swatch: swatch?.toDomain(),
      media: media?.map((m) => m.toDomain()).toList(),
    );
  }
}
