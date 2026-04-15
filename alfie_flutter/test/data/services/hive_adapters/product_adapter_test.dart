import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late ProductAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockBrand mockBrand;
  late MockPriceRange mockPriceRange;
  late MockProductVariant mockDefaultVariant;
  late MockProductVariant mockVariant;
  late MockProductColor mockColor;

  setUp(() {
    adapter = ProductAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockBrand = MockBrand();
    mockPriceRange = MockPriceRange();
    mockDefaultVariant = MockProductVariant();
    mockVariant = MockProductVariant();
    mockColor = MockProductColor();
  });

  group('ProductAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 14);
    });

    test('write() should correctly serialize Product to binary', () {
      final attributes = {'material': 'cotton'};
      final variants = [mockVariant];
      final colours = [mockColor];

      final product = Product(
        id: 'prod_123',
        styleNumber: 'style_001',
        name: 'Super T-Shirt',
        brand: mockBrand,
        priceRange: mockPriceRange,
        shortDescription: 'A great shirt',
        longDescription: 'Detailed description here.',
        attributes: attributes,
        defaultVariant: mockDefaultVariant,
        variants: variants,
        colours: colours,
      );

      adapter.write(mockWriter, product);

      verifyInOrder([
        () => mockWriter.writeString('prod_123'),
        () => mockWriter.writeString('style_001'),
        () => mockWriter.writeString('Super T-Shirt'),
        () => mockWriter.write<Brand>(
          mockBrand,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<PriceRange?>(
          mockPriceRange,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.writeString('A great shirt'),
        () => mockWriter.write<String?>(
          'Detailed description here.',
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<Map<String, String>?>(
          attributes,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<ProductVariant>(
          mockDefaultVariant,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<List<ProductVariant>>(
          variants,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<List<ProductColor>?>(
          colours,
          writeTypeId: any(named: 'writeTypeId'),
        ),
      ]);
    });

    test('read() should correctly deserialize binary to Product', () {
      final attributes = {'material': 'cotton'};
      final variants = [mockVariant];
      final colours = [mockColor];

      // Queue up responses for readString()
      final stringReturns = [
        'prod_123', // id
        'style_001', // styleNumber
        'Super T-Shirt', // name
        'A great shirt', // shortDescription
      ];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      // Queue up responses for read()
      final dynamicReturns = [
        mockBrand, // brand
        mockPriceRange, // priceRange
        'Detailed description here.', // longDescription
        attributes, // attributes
        mockDefaultVariant, // defaultVariant
        variants, // variants
        colours, // colours
      ];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      // Verify the returned properties
      expect(result.id, 'prod_123');
      expect(result.styleNumber, 'style_001');
      expect(result.name, 'Super T-Shirt');
      expect(result.brand, mockBrand);
      expect(result.priceRange, mockPriceRange);
      expect(result.shortDescription, 'A great shirt');
      expect(result.longDescription, 'Detailed description here.');
      expect(result.attributes, attributes);
      expect(result.defaultVariant, mockDefaultVariant);
      expect(result.variants, variants);
      expect(result.colours, colours);

      // Verify exact number of calls
      verify(() => mockReader.readString()).called(4);
      verify(() => mockReader.read()).called(7);
    });
  });
}
