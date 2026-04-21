import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/services/hive_adapters/address_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late AddressAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = AddressAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('AddressAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 16);
    });

    test('write() should correctly serialize Address to binary', () {
      const address = Address(
        country: 'Portugal',
        postalCode: '4400-123',
        city: 'Vila Nova de Gaia',
        street: 'Avenida da República',
        addressLine2: 'Apt 4B',
      );

      adapter.write(mockWriter, address);

      verifyInOrder([
        () => mockWriter.writeString('Portugal'),
        () => mockWriter.writeString('4400-123'),
        () => mockWriter.writeString('Vila Nova de Gaia'),
        () => mockWriter.writeString('Avenida da República'),
        () => mockWriter.writeString('Apt 4B'),
      ]);
    });

    test('read() should correctly deserialize binary to Address', () {
      final stringReturns = [
        'Portugal',
        '4400-123',
        'Vila Nova de Gaia',
        'Avenida da República',
        'Apt 4B',
      ];

      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.country, 'Portugal');
      expect(result.postalCode, '4400-123');
      expect(result.city, 'Vila Nova de Gaia');
      expect(result.street, 'Avenida da República');
      expect(result.addressLine2, 'Apt 4B');

      verify(() => mockReader.readString()).called(5);
    });
  });
}
