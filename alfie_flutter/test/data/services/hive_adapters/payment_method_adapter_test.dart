import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/services/hive_adapters/payment_method_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late PaymentMethodAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = PaymentMethodAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('PaymentMethodAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 18);
    });

    test('write() should correctly serialize PaymentMethod to binary', () {
      const method = PaymentMethod(
        id: 'pm_123',
        name: 'Credit Card',
        description: 'Pay with Visa or Mastercard',
      );

      adapter.write(mockWriter, method);

      verifyInOrder([
        () => mockWriter.writeString('pm_123'),
        () => mockWriter.writeString('Credit Card'),
        () => mockWriter.writeString('Pay with Visa or Mastercard'),
      ]);
    });

    test('read() should correctly deserialize binary to PaymentMethod', () {
      final stringReturns = [
        'pm_123',
        'Credit Card',
        'Pay with Visa or Mastercard',
      ];

      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.id, 'pm_123');
      expect(result.name, 'Credit Card');
      expect(result.description, 'Pay with Visa or Mastercard');

      verify(() => mockReader.readString()).called(3);
    });
  });
}
