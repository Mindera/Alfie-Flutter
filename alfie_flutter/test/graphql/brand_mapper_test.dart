import 'package:flutter_test/flutter_test.dart';

import 'package:alfie_flutter/graphql/extensions/brand_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';

void main() {
  group("Brand Mapper Tests -", () {
    test("should map a Brand Fragment to a domain Brand model", () {
      final brandFragment = Fragment$BrandFragment(
        id: 'brand_123',
        name: 'Alfie Brand',
        slug: 'alfiebrand',
      );

      final result = brandFragment.toDomain();

      expect(result.id, 'brand_123');
      expect(result.name, 'Alfie Brand');
    });
  });
}
