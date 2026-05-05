import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/models/size.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_variant_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late ProductVariantAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockProductSize mockSize;
  late MockPrice mockPrice;

  setUp(() {
    adapter = ProductVariantAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockSize = MockProductSize();
    mockPrice = MockPrice();
  });

  group('ProductVariantAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 13);
    });

    test(
      'write() should correctly serialize ProductVariant to binary (with optional fields)',
      () {
        final attributes = {'fit': 'slim', 'material': 'cotton'};

        final variant = ProductVariant(
          sku: 'SKU-123',
          size: mockSize,
          colorId: 'color_789',
          attributes: attributes,
          stock: 50,
          price: mockPrice,
        );

        adapter.write(mockWriter, variant);

        // Verify the precise sequence of writes with appropriate generic types
        verifyInOrder([
          () => mockWriter.writeString('SKU-123'),
          () => mockWriter.write<ProductSize?>(
            mockSize,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<String?>(
            'color_789',
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Map<String, String>?>(
            attributes,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.writeInt(50),
          () => mockWriter.write<Price>(
            mockPrice,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize ProductVariant to binary (without optional fields)',
      () {
        final variant = ProductVariant(
          sku: 'SKU-123',
          size: null,
          colorId: null,
          attributes: null,
          stock: 0,
          price: mockPrice,
        );

        adapter.write(mockWriter, variant);

        verifyInOrder([
          () => mockWriter.writeString('SKU-123'),
          () => mockWriter.write<ProductSize?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Map<String, String>?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.writeInt(0),
          () => mockWriter.write<Price>(
            mockPrice,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to ProductVariant', () {
      final attributes = {'fit': 'slim'};

      // 1. readString for sku
      when(() => mockReader.readString()).thenReturn('SKU-123');

      // 2. readInt for stock
      when(() => mockReader.readInt()).thenReturn(25);

      // 3. Queue up responses for read()
      // Sequence: size, colorId, attributes, price
      final dynamicReturns = [mockSize, 'color_789', attributes, mockPrice];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      // Verify the returned properties
      expect(result.sku, 'SKU-123');
      expect(result.size, mockSize);
      expect(result.colorId, 'color_789');
      expect(result.attributes, attributes);
      expect(result.stock, 25);
      expect(result.price, mockPrice);

      // Verify exact sequence and number of calls
      verifyInOrder([
        () => mockReader.readString(), // sku
        () => mockReader.read(), // size
        () => mockReader.read(), // colorId
        () => mockReader.read(), // attributes
        () => mockReader.readInt(), // stock
        () => mockReader.read(), // price
      ]);
    });
  });
}
