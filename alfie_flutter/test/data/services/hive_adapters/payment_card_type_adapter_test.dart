import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/data/services/hive_adapters/payment_card_type_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late CardTypeAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = CardTypeAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('CardTypeAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 21);
    });

    test('write() should correctly serialize PaymentCardType to binary', () {
      adapter.write(mockWriter, PaymentCardType.visa);

      // visa is index 1
      verify(() => mockWriter.writeInt(1)).called(1);
    });

    test('read() should correctly deserialize binary to PaymentCardType', () {
      when(() => mockReader.readInt()).thenReturn(0); // master is index 0

      final result = adapter.read(mockReader);

      expect(result, PaymentCardType.master);
      verify(() => mockReader.readInt()).called(1);
    });
  });
}
