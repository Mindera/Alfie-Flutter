import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/graphql/extensions/product_color_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/colour_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/image_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/media_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product Color Mapper Tests -", () {
    test(
      "should map a Colour Fragment to a domain ProductColor model with all fields",
      () {
        final colourFragment = Fragment$ColourFragment(
          id: 'col_789',
          name: 'Midnight Blue',
          swatch: Fragment$ImageFragment(
            alt: 'swatch_1',
            url: 'https://example.com/swatch.jpg',
            mediaContentType: Enum$MediaContentType.IMAGE,
          ),
          media: [
            Fragment$MediaFragment$$Image(
                  alt: 'med_1',
                  url: 'https://example.com/media.jpg',
                  mediaContentType: Enum$MediaContentType.IMAGE,
                )
                as Fragment$MediaFragment,
          ],
        );

        final result = colourFragment.toDomain();

        expect(result.id, 'col_789');
        expect(result.name, 'Midnight Blue');

        expect(result.swatch?.alt, 'swatch_1');
        expect(result.swatch, isA<MediaImage>());

        expect(result.media, isNotNull);
        expect(result.media!.length, 1);
        expect(result.media!.first.alt, 'med_1');
      },
    );

    test("should handle null swatch and media gracefully", () {
      final colourFragment = Fragment$ColourFragment(
        id: 'col_000',
        name: 'Transparent',
        swatch: null,
        media: null,
      );

      final result = colourFragment.toDomain();

      expect(result.id, 'col_000');
      expect(result.name, 'Transparent');
      expect(result.swatch, isNull);
      expect(result.media, isNull);
    });

    test("should map an empty media list correctly", () {
      final colourFragment = Fragment$ColourFragment(
        id: 'col_123',
        name: 'Basic Red',
        swatch: null,
        media: [],
      );

      final result = colourFragment.toDomain();

      expect(result.media, isEmpty);
    });
  });
}
