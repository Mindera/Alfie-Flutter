import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/services/hive_adapters/price_range_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late PriceRangeAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;
  late MockMoney mockLow;
  late MockMoney mockHigh;

  setUp(() {
    adapter = PriceRangeAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
    mockLow = MockMoney();
    mockHigh = MockMoney();
  });

  group('PriceRangeAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 3);
    });

    test(
      'write() should correctly serialize PriceRange to binary (with high price)',
      () {
        final priceRange = PriceRange(low: mockLow, high: mockHigh);

        adapter.write(mockWriter, priceRange);

        // Verify the writes happen in order, specifying <Money> and <Money?>
        // generics so mocktail matches the exact method signatures.
        verifyInOrder([
          () => mockWriter.write<Money>(
            mockLow,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Money?>(
            mockHigh,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize PriceRange to binary (without high price)',
      () {
        final priceRange = PriceRange(low: mockLow, high: null);

        adapter.write(mockWriter, priceRange);

        verifyInOrder([
          () => mockWriter.write<Money>(
            mockLow,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Money?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to PriceRange', () {
      // Queue up the read() responses for low, then high
      final sequentialReturns = [mockLow, mockHigh];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => sequentialReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.low, mockLow);
      expect(result.high, mockHigh);

      // Verify read() was called exactly twice
      verify(() => mockReader.read()).called(2);
    });
  });
}
