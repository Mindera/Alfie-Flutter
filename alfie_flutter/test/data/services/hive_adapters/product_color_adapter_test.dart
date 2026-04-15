import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_color_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late ProductColorAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockMediaImage mockSwatch;
  late MockMedia mockMediaItem;

  setUp(() {
    adapter = ProductColorAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockSwatch = MockMediaImage();
    mockMediaItem = MockMedia();
  });

  group('ProductColorAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 12);
    });

    test(
      'write() should correctly serialize ProductColor to binary (with optional fields)',
      () {
        final mediaList = [mockMediaItem];

        final productColor = ProductColor(
          id: 'color_123',
          name: 'Navy Blue',
          swatch: mockSwatch,
          media: mediaList,
        );

        adapter.write(mockWriter, productColor);

        // Verify the precise sequence of writes with appropriate generic types
        verifyInOrder([
          () => mockWriter.writeString('color_123'),
          () => mockWriter.writeString('Navy Blue'),
          () => mockWriter.write<MediaImage?>(
            mockSwatch,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<Media>?>(
            mediaList,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize ProductColor to binary (without optional fields)',
      () {
        final productColor = ProductColor(
          id: 'color_123',
          name: 'Navy Blue',
          swatch: null,
          media: null,
        );

        adapter.write(mockWriter, productColor);

        verifyInOrder([
          () => mockWriter.writeString('color_123'),
          () => mockWriter.writeString('Navy Blue'),
          () => mockWriter.write<MediaImage?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<Media>?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to ProductColor', () {
      final mediaList = [mockMediaItem];

      // Queue up responses for readString() (id, name)
      final stringReturns = ['color_123', 'Navy Blue'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      // Queue up responses for read() (swatch, media)
      final dynamicReturns = [mockSwatch, mediaList];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      // Verify the returned properties
      expect(result.id, 'color_123');
      expect(result.name, 'Navy Blue');
      expect(result.swatch, mockSwatch);
      expect(result.media, mediaList);

      // Verify exact number of calls
      verify(() => mockReader.readString()).called(2);
      verify(() => mockReader.read()).called(2);
    });
  });
}
