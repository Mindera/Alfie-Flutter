import 'package:alfie_flutter/data/models/size.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/size_fragment.graphql.dart';

extension SizeMapper on Fragment$SizeTreeFragment {
  ProductSize toDomain() {
    return ProductSize(
      id: id,
      value: value,
      scale: scale,
      description: description,
      sizeGuide: sizeGuide?.toDomain(),
    );
  }
}

extension SizeGuideMapper on Fragment$SizeGuideTreeFragment {
  SizeGuide toDomain() {
    return SizeGuide(
      id: id,
      name: name,
      description: description,
      sizes: sizes.map((s) => s.toDomain()).toList(),
    );
  }
}

extension NestedSizeMapper on Fragment$SizeGuideTreeFragment$sizes {
  ProductSize toDomain() {
    return ProductSize(
      id: id,
      value: value,
      scale: scale,
      description: description,
      sizeGuide: sizeGuide == null
          ? null
          : SizeGuide(
              id: sizeGuide!.id,
              name: sizeGuide!.name,
              description: sizeGuide!.description,
              sizes: [],
            ), // Avoid circular reference
    );
  }
}
