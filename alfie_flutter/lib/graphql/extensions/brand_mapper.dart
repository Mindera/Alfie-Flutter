import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';

/// Converts a GraphQL Brand into a domain model.
extension BrandMapper on Fragment$BrandFragment {
  /// Converts this brand fragment to a [Brand] domain model.
  Brand toDomain() => Brand(id: id, name: name);
}
