import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/data/services/hive_adapters/payment_card_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late PaymentCardAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = PaymentCardAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('PaymentCardAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 22);
    });

    test('write() should correctly serialize PaymentCard to binary', () {
      const card = PaymentCard(
        type: PaymentCardType.master,
        number: '5555444433332222',
        name: 'Jane Doe',
        month: 10,
        year: 2028,
        cvv: 999,
      );

      adapter.write(mockWriter, card);

      verifyInOrder([
        () => mockWriter.write<PaymentCardType>(
          PaymentCardType.master,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<String>(
          '5555444433332222',
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<String>(
          'Jane Doe',
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<int>(10, writeTypeId: any(named: 'writeTypeId')),
        () =>
            mockWriter.write<int>(2028, writeTypeId: any(named: 'writeTypeId')),
        () =>
            mockWriter.write<int>(999, writeTypeId: any(named: 'writeTypeId')),
      ]);
    });

    test('read() should correctly deserialize binary to PaymentCard', () {
      final dynamicReturns = [
        PaymentCardType.visa,
        '4111111111111111',
        'John Doe',
        12,
        2030,
        123,
      ];

      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.type, PaymentCardType.visa);
      expect(result.number, '4111111111111111');
      expect(result.name, 'John Doe');
      expect(result.month, 12);
      expect(result.year, 2030);
      expect(result.cvv, 123);

      verify(() => mockReader.read()).called(6);
    });
  });
}
