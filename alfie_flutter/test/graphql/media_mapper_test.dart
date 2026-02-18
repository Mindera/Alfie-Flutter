import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/graphql/extensions/media_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/image_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/media_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Media Mapper Tests -", () {
    test("should map a Media Fragment as an Image", () {
      final imageFragment = Fragment$MediaFragment$$Image(
        url: 'https://example.com/photo.jpg',
        alt: 'A beautiful photo',
        mediaContentType: Enum$MediaContentType.IMAGE,
      );
      final media = imageFragment as Fragment$MediaFragment;

      final result = media.toDomain();

      expect(result, isA<MediaImage>());
      final imageResult = result as MediaImage;
      expect(imageResult.url, 'https://example.com/photo.jpg');
      expect(imageResult.alt, 'A beautiful photo');
    });

    test("should map Media Fragment as a Video with all nested sources", () {
      final videoFragment = Fragment$MediaFragment$$Video(
        alt: 'Product Video',
        previewImage: Fragment$ImageFragment(
          url: 'https://example.com/preview.jpg',
          alt: 'Preview',
          mediaContentType: Enum$MediaContentType.VIDEO,
        ),
        sources: [
          Fragment$MediaFragment$$Video$sources(
            format: Enum$VideoFormat.MP4,
            mimeType: 'video/mp4',
            url: 'https://example.com/video.mp4',
          ),
          Fragment$MediaFragment$$Video$sources(
            format: Enum$VideoFormat.WEBM,
            mimeType: 'video/webm',
            url: 'https://example.com/video.webm',
          ),
        ],
        mediaContentType: Enum$MediaContentType.VIDEO,
      );

      // Creating the union type for Video
      final mediaFragment = videoFragment as Fragment$MediaFragment;

      final result = mediaFragment.toDomain();

      expect(result, isA<MediaVideo>());
      final videoResult = result as MediaVideo;
      expect(videoResult.alt, 'Product Video');
      expect(videoResult.previewImage?.url, 'https://example.com/preview.jpg');
      expect(videoResult.sources.length, 2);

      expect(videoResult.sources[0].format, VideoFormat.mp4);
      expect(videoResult.sources[1].format, VideoFormat.webm);
    });

    test(
      "should return Media with unknown content type when __typename is unhandled (orElse branch)",
      () {
        final unknownMediaFragment = Fragment$MediaFragment(
          $__typename: 'NewMediaFormat',
        );

        final result = unknownMediaFragment.toDomain();

        expect(result.mediaContentType, MediaContentType.unknown);
        expect(result, isNot(isA<MediaImage>()));
        expect(result, isNot(isA<MediaVideo>()));
      },
    );
  });

  group("Video Format Enum Mapping -", () {
    test("should map Video Format to domain Video Format", () {
      final source = Fragment$MediaFragment$$Video$sources(
        format: Enum$VideoFormat.$unknown,
        mimeType: 'video/unknown',
        url: 'url',
      );

      final result = source.toDomain();
      expect(result.format, VideoFormat.unknown);
    });
  });
}
