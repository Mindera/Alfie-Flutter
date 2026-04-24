import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/services/hive_adapters/delivery_method_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late DeliveryMethodAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = DeliveryMethodAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('DeliveryMethodAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 17);
    });

    test('write() should correctly serialize DeliveryMethod to binary', () {
      adapter.write(mockWriter, DeliveryMethod.express);

      // standard = 0, express = 1
      verify(() => mockWriter.writeInt(1)).called(1);
    });

    test('read() should correctly deserialize binary to DeliveryMethod', () {
      when(() => mockReader.readInt()).thenReturn(0);

      final result = adapter.read(mockReader);

      expect(result, DeliveryMethod.standard);
      verify(() => mockReader.readInt()).called(1);
    });
  });
}
