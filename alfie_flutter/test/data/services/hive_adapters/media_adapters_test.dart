import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/services/hive_adapters/media_adapters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  setUp(() {
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
  });

  // ==========================================
  // MediaContentTypeAdapter Tests
  // ==========================================
  group('MediaContentTypeAdapter Tests -', () {
    late MediaContentTypeAdapter adapter;

    setUp(() {
      adapter = MediaContentTypeAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 5);
    });

    test(
      'write() should correctly serialize enum to binary using its index',
      () {
        // MediaContentType.video is index 1 (image=0, video=1, unknown=2)
        adapter.write(mockWriter, MediaContentType.video);

        verify(() => mockWriter.writeInt(1)).called(1);
      },
    );

    test(
      'read() should correctly deserialize binary to enum using its index',
      () {
        when(() => mockReader.readInt()).thenReturn(0); // index 0 is image

        final result = adapter.read(mockReader);

        expect(result, MediaContentType.image);
        verify(() => mockReader.readInt()).called(1);
      },
    );
  });

  // ==========================================
  // VideoFormatAdapter Tests
  // ==========================================
  group('VideoFormatAdapter Tests -', () {
    late VideoFormatAdapter adapter;

    setUp(() {
      adapter = VideoFormatAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 6);
    });

    test(
      'write() should correctly serialize enum to binary using its index',
      () {
        // VideoFormat.webm is index 1 (mp4=0, webm=1, unknown=2)
        adapter.write(mockWriter, VideoFormat.webm);

        verify(() => mockWriter.writeInt(1)).called(1);
      },
    );

    test(
      'read() should correctly deserialize binary to enum using its index',
      () {
        when(() => mockReader.readInt()).thenReturn(0); // index 0 is mp4

        final result = adapter.read(mockReader);

        expect(result, VideoFormat.mp4);
        verify(() => mockReader.readInt()).called(1);
      },
    );
  });

  // ==========================================
  // MediaImageAdapter Tests
  // ==========================================
  group('MediaImageAdapter Tests -', () {
    late MediaImageAdapter adapter;

    setUp(() {
      adapter = MediaImageAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 7);
    });

    test(
      'write() should correctly serialize MediaImage to binary (with alt text)',
      () {
        final image = MediaImage(
          url: 'https://example.com/img.jpg',
          alt: 'A nice image',
        );

        adapter.write(mockWriter, image);

        verifyInOrder([
          () => mockWriter.writeString('https://example.com/img.jpg'),
          () => mockWriter.write<String?>(
            'A nice image',
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize MediaImage to binary (without alt text)',
      () {
        final image = MediaImage(url: 'https://example.com/img.jpg', alt: null);

        adapter.write(mockWriter, image);

        verifyInOrder([
          () => mockWriter.writeString('https://example.com/img.jpg'),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to MediaImage', () {
      when(
        () => mockReader.readString(),
      ).thenReturn('https://example.com/img.jpg');
      when(() => mockReader.read()).thenReturn('A nice image');

      final result = adapter.read(mockReader);

      expect(result.url, 'https://example.com/img.jpg');
      expect(result.alt, 'A nice image');
      expect(
        result.mediaContentType,
        MediaContentType.image,
      ); // Inherited from super

      verifyInOrder([() => mockReader.readString(), () => mockReader.read()]);
    });
  });

  // ==========================================
  // VideoSourceAdapter Tests
  // ==========================================
  group('VideoSourceAdapter Tests -', () {
    late VideoSourceAdapter adapter;

    setUp(() {
      adapter = VideoSourceAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 8);
    });

    test('write() should correctly serialize VideoSource to binary', () {
      final source = VideoSource(
        format: VideoFormat.mp4,
        mimeType: 'video/mp4',
        url: 'https://example.com/video.mp4',
      );

      adapter.write(mockWriter, source);

      verifyInOrder([
        () => mockWriter.write<VideoFormat>(
          VideoFormat.mp4,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.writeString('video/mp4'),
        () => mockWriter.writeString('https://example.com/video.mp4'),
      ]);
    });

    test('read() should correctly deserialize binary to VideoSource', () {
      when(() => mockReader.read()).thenReturn(VideoFormat.mp4);

      // readString() is called twice, queue responses
      final stringReturns = ['video/mp4', 'https://example.com/video.mp4'];
      when(
        () => mockReader.readString(),
      ).thenAnswer((_) => stringReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.format, VideoFormat.mp4);
      expect(result.mimeType, 'video/mp4');
      expect(result.url, 'https://example.com/video.mp4');

      verifyInOrder([
        () => mockReader.read(),
        () => mockReader.readString(),
        () => mockReader.readString(),
      ]);
    });
  });

  // ==========================================
  // MediaVideoAdapter Tests
  // ==========================================
  group('MediaVideoAdapter Tests -', () {
    late MediaVideoAdapter adapter;
    late MockVideoSource mockSource;
    late MockMediaImage mockPreview;

    setUp(() {
      adapter = MediaVideoAdapter();
      mockSource = MockVideoSource();
      mockPreview = MockMediaImage();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 9);
    });

    test(
      'write() should correctly serialize MediaVideo to binary (with optional fields)',
      () {
        final sources = [mockSource];
        final video = MediaVideo(
          alt: 'A nice video',
          sources: sources,
          previewImage: mockPreview,
        );

        adapter.write(mockWriter, video);

        verifyInOrder([
          () => mockWriter.write<String?>(
            'A nice video',
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<VideoSource>>(
            sources,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<MediaImage?>(
            mockPreview,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize MediaVideo to binary (without optional fields)',
      () {
        final sources = [mockSource];
        final video = MediaVideo(
          alt: null,
          sources: sources,
          previewImage: null,
        );

        adapter.write(mockWriter, video);

        verifyInOrder([
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<VideoSource>>(
            sources,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<MediaImage?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to MediaVideo', () {
      final sources = [mockSource];

      // read() is called 3 times, queue responses: alt, sources, previewImage
      final dynamicReturns = ['A nice video', sources, mockPreview];
      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.alt, 'A nice video');
      expect(result.sources, sources);
      expect(result.previewImage, mockPreview);
      expect(
        result.mediaContentType,
        MediaContentType.video,
      ); // Inherited from super

      verify(() => mockReader.read()).called(3);
    });
  });
}
