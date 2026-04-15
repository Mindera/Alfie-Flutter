import 'package:alfie_flutter/data/models/size.dart';
import 'package:alfie_flutter/data/services/hive_adapters/size_adapters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockProductSize mockSize;
  late MockSizeGuide mockGuide;

  setUp(() {
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockSize = MockProductSize();
    mockGuide = MockSizeGuide();
  });

  // ==========================================
  // SizeGuideAdapter Tests
  // ==========================================
  group('SizeGuideAdapter Tests -', () {
    late SizeGuideAdapter guideAdapter;

    setUp(() {
      guideAdapter = SizeGuideAdapter();
    });

    test('should have the correct typeId', () {
      expect(guideAdapter.typeId, 10);
    });

    test(
      'write() should correctly serialize SizeGuide to binary (with optional fields)',
      () {
        final sizesList = [mockSize];
        final guide = SizeGuide(
          id: 'guide_123',
          name: 'EU Standard',
          description: 'Standard European shoe sizes',
          sizes: sizesList,
        );

        guideAdapter.write(mockWriter, guide);

        verifyInOrder([
          () => mockWriter.writeString('guide_123'),
          () => mockWriter.writeString('EU Standard'),
          () => mockWriter.write<String?>(
            'Standard European shoe sizes',
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<ProductSize>>(
            sizesList,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize SizeGuide to binary (without optional fields)',
      () {
        final sizesList = <ProductSize>[];
        final guide = SizeGuide(
          id: 'guide_123',
          name: 'EU Standard',
          description: null,
          sizes: sizesList,
        );

        guideAdapter.write(mockWriter, guide);

        verifyInOrder([
          () => mockWriter.writeString('guide_123'),
          () => mockWriter.writeString('EU Standard'),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<ProductSize>>(
            sizesList,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to SizeGuide', () {
      final sizesList = [mockSize];

      // Strings: id, name
      final stringReturns = ['guide_123', 'EU Standard'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      // Dynamic reads: description, sizes
      final dynamicReturns = ['Standard European shoe sizes', sizesList];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = guideAdapter.read(mockReader);

      expect(result.id, 'guide_123');
      expect(result.name, 'EU Standard');
      expect(result.description, 'Standard European shoe sizes');
      expect(result.sizes, sizesList);

      verify(() => mockReader.readString()).called(2);
      verify(() => mockReader.read()).called(2);
    });
  });

  // ==========================================
  // ProductSizeAdapter Tests
  // ==========================================
  group('ProductSizeAdapter Tests -', () {
    late ProductSizeAdapter sizeAdapter;

    setUp(() {
      sizeAdapter = ProductSizeAdapter();
    });

    test('should have the correct typeId', () {
      expect(sizeAdapter.typeId, 11);
    });

    test(
      'write() should correctly serialize ProductSize to binary (with optional fields)',
      () {
        final size = ProductSize(
          id: 'size_42',
          value: '42',
          scale: 'EU',
          description: 'Runs slightly large',
          sizeGuide: mockGuide,
        );

        sizeAdapter.write(mockWriter, size);

        verifyInOrder([
          () => mockWriter.writeString('size_42'),
          () => mockWriter.writeString('42'),
          () => mockWriter.write<String?>(
            'EU',
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<String?>(
            'Runs slightly large',
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<SizeGuide?>(
            mockGuide,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize ProductSize to binary (without optional fields)',
      () {
        final size = ProductSize(
          id: 'size_42',
          value: '42',
          scale: null,
          description: null,
          sizeGuide: null,
        );

        sizeAdapter.write(mockWriter, size);

        verifyInOrder([
          () => mockWriter.writeString('size_42'),
          () => mockWriter.writeString('42'),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<SizeGuide?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to ProductSize', () {
      // Strings: id, value
      final stringReturns = ['size_42', '42'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      // Dynamic reads: scale, description, sizeGuide
      final dynamicReturns = ['EU', 'Runs slightly large', mockGuide];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = sizeAdapter.read(mockReader);

      expect(result.id, 'size_42');
      expect(result.value, '42');
      expect(result.scale, 'EU');
      expect(result.description, 'Runs slightly large');
      expect(result.sizeGuide, mockGuide);

      verify(() => mockReader.readString()).called(2);
      verify(() => mockReader.read()).called(3);
    });
  });
}
