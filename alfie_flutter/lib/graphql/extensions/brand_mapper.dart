import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';

extension BrandMapper on Fragment$BrandFragment {
  Brand toDomain() => Brand(id: id, name: name);
}
