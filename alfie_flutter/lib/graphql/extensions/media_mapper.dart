import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/image_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/fragments/media_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';

/// Converts a GraphQL media fragment into a domain model using pattern matching.
///
/// Supports multiple media types (image, video) with graceful fallback to
/// [MediaContentType.unknown] for unsupported or future media types.
extension MediaMapper on Fragment$MediaFragment {
  /// Converts this media fragment to a [Media] domain model.
  ///
  /// Uses a sealed union pattern (`when` method) to handle different media
  /// types, ensuring type-safe transformation of polymorphic media data.
  Media toDomain() {
    return when(
      image: (image) => MediaImageMapper(image).toDomain(),
      video: (video) => video.toDomain(),
      orElse: () => Media(mediaContentType: MediaContentType.unknown),
    );
  }
}

/// Converts a GraphQL image fragment into a domain model.
extension MediaImageMapper on Fragment$ImageFragment {
  /// Converts this image fragment to a [MediaImage] domain model.
  MediaImage toDomain() {
    return MediaImage(url: url, alt: alt);
  }
}

/// Converts a GraphQL video fragment into a domain model.
extension MediaVideoMapper on Fragment$MediaFragment$$Video {
  /// Converts this video fragment to a [MediaVideo] domain model.
  ///
  /// Handles nested transformations of video sources and optional preview image
  /// using their respective mappers.
  MediaVideo toDomain() {
    return MediaVideo(
      alt: alt,
      sources: sources.map((source) => source.toDomain()).toList(),
      previewImage: previewImage?.toDomain(),
    );
  }
}

/// Converts a GraphQL video source fragment into a domain model.
extension VideoSourceMapper on Fragment$MediaFragment$$Video$sources {
  /// Converts this video source fragment to a [VideoSource] domain model.
  VideoSource toDomain() {
    return VideoSource(
      format: _mapVideoFormat(format),
      mimeType: mimeType,
      url: url,
    );
  }
}

/// Maps GraphQL video format enum to domain video format enum.
///
/// Provides centralized conversion logic for video formats with
/// graceful handling of unknown formats.
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
