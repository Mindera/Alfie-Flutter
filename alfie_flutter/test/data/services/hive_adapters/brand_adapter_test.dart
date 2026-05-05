import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/services/hive_adapters/brand_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late BrandAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = BrandAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('BrandAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 1);
    });

    test('write() should correctly serialize Brand to binary', () {
      const brand = Brand(id: 'brand_123', name: 'Acme Corp');

      adapter.write(mockWriter, brand);

      verifyInOrder([
        () => mockWriter.writeString('brand_123'),
        () => mockWriter.writeString('Acme Corp'),
      ]);
    });

    test('read() should correctly deserialize binary to Brand', () {
      final sequentialReturns = ['brand_123', 'Acme Corp'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => sequentialReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.id, 'brand_123');
      expect(result.name, 'Acme Corp');

      verify(() => mockReader.readString()).called(2);
    });
  });
}
