import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/media_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/image_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';

extension MediaImageMapper on Fragment$ImageFragment {
  MediaImage toDomain() {
    return MediaImage(url: url, alt: alt);
  }
}

extension MediaMapper on Fragment$MediaFragment {
  Media toMedia() {
    return when(
      image: (image) => image.toDomain(),
      video: (video) => video.toDomain(),
      orElse: () => Media(mediaContentType: MediaContentType.unknown),
    );
  }
}

extension MediaVideoMapper on Fragment$MediaFragment$$Video {
  MediaVideo toDomain() {
    return MediaVideo(
      alt: alt,
      sources: sources.map((s) => s.toDomain()).toList(),
      previewImage: previewImage?.toDomain(),
    );
  }
}

extension VideoSourceMapper on Fragment$MediaFragment$$Video$sources {
  VideoSource toDomain() {
    return VideoSource(
      format: _mapVideoFormat(format),
      mimeType: mimeType,
      url: url,
    );
  }
}

VideoFormat _mapVideoFormat(Enum$VideoFormat format) {
  switch (format) {
    case Enum$VideoFormat.MP4:
      return VideoFormat.mp4;
    case Enum$VideoFormat.WEBM:
      return VideoFormat.webm;
    case Enum$VideoFormat.$unknown:
      return VideoFormat.unknown;
  }
}
