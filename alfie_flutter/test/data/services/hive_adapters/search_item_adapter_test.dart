import 'package:alfie_flutter/data/services/hive_adapters/search_item_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:alfie_flutter/data/models/search_item.dart';

class MockBinaryReader extends Mock implements BinaryReader {}

class MockBinaryWriter extends Mock implements BinaryWriter {}

void main() {
  late SearchItemAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    adapter = SearchItemAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  group('SearchItemAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 0);
    });

    test('write() should correctly serialize SearchItem to binary', () {
      // Arrange
      final timestamp = DateTime(2023, 10, 27, 12, 0);
      final searchItem = SearchItem(
        query: 'flutter tests',
        timestamp: timestamp,
      );

      // Act
      adapter.write(mockWriter, searchItem);

      // Assert
      // Verify the query string is written first
      verify(() => mockWriter.writeString('flutter tests')).called(1);
      // Verify the timestamp is written as milliseconds
      verify(
        () => mockWriter.writeInt(timestamp.millisecondsSinceEpoch),
      ).called(1);
    });

    test('read() should correctly deserialize binary to SearchItem', () {
      // Arrange
      final timestamp = DateTime(2023, 10, 27, 12, 0);
      when(() => mockReader.readString()).thenReturn('riverpod rules');
      when(
        () => mockReader.readInt(),
      ).thenReturn(timestamp.millisecondsSinceEpoch);

      // Act
      final result = adapter.read(mockReader);

      // Assert
      expect(result.query, 'riverpod rules');
      expect(result.timestamp, timestamp);

      // Ensure we read in the same order we wrote
      verifyInOrder([
        () => mockReader.readString(),
        () => mockReader.readInt(),
      ]);
    });
  });
}
