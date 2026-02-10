import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/graphql/extensions/media_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/colour_fragment.graphql.dart';

extension ProductColorMapper on Fragment$ColourFragment {
  ProductColor toDomain() {
    return ProductColor(
      id: id,
      name: name,
      swatch: swatch?.toDomain(),
      media: media?.map((m) => m.toDomain()).toList(),
    );
  }
}
