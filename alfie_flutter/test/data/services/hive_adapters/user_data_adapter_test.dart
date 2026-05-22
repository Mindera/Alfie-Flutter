import 'package:alfie_flutter/data/models/user_data.dart';
// Adjust the path below if your folder structure is slightly different
import 'package:alfie_flutter/data/services/hive_adapters/user_data_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late UserDataAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = UserDataAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('UserDataAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 19);
    });

    test('write() should correctly serialize UserData to binary', () {
      const user = UserData(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phoneNumber: '+351 912 345 678',
      );

      adapter.write(mockWriter, user);

      verifyInOrder([
        () => mockWriter.writeString('John'),
        () => mockWriter.writeString('Doe'),
        () => mockWriter.writeString('john@example.com'),
        () => mockWriter.writeString('+351 912 345 678'),
      ]);
    });

    test('read() should correctly deserialize binary to UserData', () {
      final stringReturns = [
        'John',
        'Doe',
        'john@example.com',
        '+351 912 345 678',
      ];

      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.firstName, 'John');
      expect(result.lastName, 'Doe');
      expect(result.email, 'john@example.com');
      expect(result.phoneNumber, '+351 912 345 678');

      verify(() => mockReader.readString()).called(4);
    });
  });
}
