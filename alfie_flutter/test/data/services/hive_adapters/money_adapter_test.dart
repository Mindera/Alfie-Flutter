import 'package:alfie_flutter/data/models/money.dart';
// Adjust the path below if your folder structure is slightly different
import 'package:alfie_flutter/data/services/hive_adapters/money_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late MoneyAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = MoneyAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('MoneyAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 2);
    });

    test('write() should correctly serialize Money to binary', () {
      final money = Money(
        currencyCode: 'USD',
        amount: 149.99,
        formatted: '\$149.99',
      );

      adapter.write(mockWriter, money);

      // Verify that the properties are written in the exact correct order
      verifyInOrder([
        () => mockWriter.writeString('USD'),
        () => mockWriter.writeDouble(149.99),
        () => mockWriter.writeString('\$149.99'),
      ]);
    });

    test('read() should correctly deserialize binary to Money', () {
      // Queue up the string responses since readString() is called twice
      // (first for currencyCode, then later for formatted)
      final stringReturns = ['EUR', '€45.00'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      // Stub the double read
      when(() => mockReader.readDouble()).thenReturn(45.00);

      final result = adapter.read(mockReader);

      // Verify the returned properties
      expect(result.currencyCode, 'EUR');
      expect(result.amount, 45.00);
      expect(result.formatted, '€45.00');

      // Verify the exact sequence of reads
      verifyInOrder([
        () => mockReader.readString(),
        () => mockReader.readDouble(),
        () => mockReader.readString(),
      ]);
    });
  });
}
