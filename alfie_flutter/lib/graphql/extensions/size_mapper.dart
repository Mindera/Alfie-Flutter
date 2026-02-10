import 'package:alfie_flutter/data/models/size.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/size_fragment.graphql.dart';

/// Converts a GraphQL size fragment into a domain model.
extension SizeMapper on Fragment$SizeTreeFragment {
  /// Converts this size fragment to a [ProductSize] domain model.
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

/// Converts a GraphQL size guide fragment into a domain model.
extension SizeGuideMapper on Fragment$SizeGuideTreeFragment {
  /// Converts this size guide fragment to a [SizeGuide] domain model.
  SizeGuide toDomain() {
    return SizeGuide(
      id: id,
      name: name,
      description: description,
      sizes: sizes.map((size) => size.toDomain()).toList(),
    );
  }
}

/// Converts nested size objects within a size guide to domain models.
///
/// Intentionally creates a [SizeGuide] with an empty sizes list to prevent
/// circular references when mapping nested size data.
extension NestedSizeMapper on Fragment$SizeGuideTreeFragment$sizes {
  /// Converts this nested size to a [ProductSize] domain model.
  ///
  /// If a sizeGuide is present, it is included but with an empty sizes list
  /// to break circular reference chains in the GraphQL response structure.
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
              sizes: const [],
            ),
    );
  }
}
