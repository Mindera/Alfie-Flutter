import 'package:alfie_flutter/graphql/extensions/attributes_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/attributes_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Attributes Mapper Tests -", () {
    test('should return null when the list is null', () {
      final List<Fragment$AttributesFragment>? list = null;

      expect(list.toDomain(), isNull);
    });

    test('should map a list of attribute fragments to a domain map', () {
      final attr1 = Fragment$AttributesFragment(key: 'theme', value: 'dark');
      final attr2 = Fragment$AttributesFragment(key: 'language', value: 'pt');

      final list = [attr1, attr2];

      final result = list.toDomain();

      expect(result, {'theme': 'dark', 'language': 'pt'});
    });
  });
}
