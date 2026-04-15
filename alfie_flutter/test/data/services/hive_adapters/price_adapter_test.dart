import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
// Adjust the path below if your folder structure is slightly different
import 'package:alfie_flutter/data/services/hive_adapters/price_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

class MockMoney extends Mock implements Money {}

void main() {
  late PriceAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;
  late MockMoney mockAmount;
  late MockMoney mockPreviousAmount;

  setUp(() {
    adapter = PriceAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
    mockAmount = MockMoney();
    mockPreviousAmount = MockMoney();
  });

  group('PriceAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 4);
    });

    test(
      'write() should correctly serialize Price to binary (with previousAmount)',
      () {
        final price = Price(
          amount: mockAmount,
          previousAmount: mockPreviousAmount,
        );

        adapter.write(mockWriter, price);

        // Verify the writes happen in order, specifying <Money> and <Money?>
        // generics so mocktail matches the exact method signatures.
        verifyInOrder([
          () => mockWriter.write<Money>(
            mockAmount,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Money?>(
            mockPreviousAmount,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize Price to binary (without previousAmount)',
      () {
        final price = Price(amount: mockAmount, previousAmount: null);

        adapter.write(mockWriter, price);

        verifyInOrder([
          () => mockWriter.write<Money>(
            mockAmount,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Money?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to Price', () {
      // Queue up the read() responses for amount, then previousAmount
      final sequentialReturns = [mockAmount, mockPreviousAmount];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => sequentialReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.amount, mockAmount);
      expect(result.previousAmount, mockPreviousAmount);

      // Verify read() was called exactly twice
      verify(() => mockReader.read()).called(2);
    });
  });
}
