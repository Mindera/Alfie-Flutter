import 'package:alfie_flutter/graphql/extensions/size_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/size_fragment.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Size Mapper Tests -', () {
    test('should map SizeTreeFragment to ProductSize without sizeGuide', () {
      final fragment = Fragment$SizeTreeFragment(
        id: '1',
        value: 'M',
        scale: 'US',
        description: 'Medium',
        sizeGuide: null,
      );

      final result = fragment.toDomain();

      expect(result.id, '1');
      expect(result.value, 'M');
      expect(result.scale, 'US');
      expect(result.description, 'Medium');
      expect(result.sizeGuide, isNull);
    });

    test('should map SizeTreeFragment to ProductSize with sizeGuide', () {
      final fragment = Fragment$SizeTreeFragment(
        id: '1',
        value: 'M',
        sizeGuide: Fragment$SizeGuideTreeFragment(
          id: 'g1',
          name: 'Guide',
          description: 'Desc',
          sizes: [],
        ),
      );

      final result = fragment.toDomain();

      expect(result.sizeGuide, isNotNull);
      expect(result.sizeGuide!.id, 'g1');
    });
  });

  group('SizeGuideMapper Tests', () {
    test('should map SizeGuideTreeFragment to SizeGuide', () {
      final fragment = Fragment$SizeGuideTreeFragment(
        id: 'g1',
        name: 'Guide',
        description: 'Guide Desc',
        sizes: [
          Fragment$SizeGuideTreeFragment$sizes(
            id: 's1',
            value: 'S',
            scale: 'US',
            description: 'Small',
            sizeGuide: null,
          ),
        ],
      );

      final result = fragment.toDomain();

      expect(result.id, 'g1');
      expect(result.name, 'Guide');
      expect(result.description, 'Guide Desc');
      expect(result.sizes.length, 1);
      expect(result.sizes.first.id, 's1');
    });
  });

  group('NestedSizeMapper Tests', () {
    test('should map NestedSize to ProductSize with null sizeGuide', () {
      final fragment = Fragment$SizeGuideTreeFragment$sizes(
        id: 's1',
        value: 'S',
        scale: 'US',
        description: 'Small',
        sizeGuide: null,
      );

      final result = fragment.toDomain();

      expect(result.id, 's1');
      expect(result.sizeGuide, isNull);
    });

    test(
      'should map NestedSize to ProductSize with non-null sizeGuide and empty sizes',
      () {
        final fragment = Fragment$SizeGuideTreeFragment$sizes(
          id: 's1',
          value: 'S',
          sizeGuide: Fragment$SizeGuideFragment(
            id: 'g1',
            name: 'Nested Guide',
            description: 'Nested Desc',
          ),
        );

        final result = fragment.toDomain();

        expect(result.sizeGuide, isNotNull);
        expect(result.sizeGuide!.id, 'g1');
        expect(result.sizeGuide!.name, 'Nested Guide');
        expect(result.sizeGuide!.description, 'Nested Desc');
        expect(result.sizeGuide!.sizes, isEmpty);
      },
    );
  });
}
