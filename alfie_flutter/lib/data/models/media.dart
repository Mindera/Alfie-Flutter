/// Defines the types of media content supported in the application.
enum MediaContentType { image, video, unknown }

/// Base class for media assets.
///
/// Represents a generic media item with optional alternative text
/// and a content type discriminator.
class Media {
  /// Alternative text description of the contents for accessibility purposes.
  final String? alt;

  /// The type of media content this instance represents.
  final MediaContentType mediaContentType;

  const Media({this.alt, required this.mediaContentType});

  /// Executes pattern matching based on the [mediaContentType] discriminator.
  T when<T>({
    required T Function(MediaImage) image,
    required T Function(MediaVideo) video,
    required T Function() orElse,
  }) {
    switch (mediaContentType) {
      case MediaContentType.image:
        return image(this as MediaImage);
      case MediaContentType.video:
        return video(this as MediaVideo);
      default:
        return orElse();
    }
  }

  /// Safely extracts the primary URL from the underlying [Media] type.
  ///
  /// Returns an empty string if no valid source is found.
  String get firstUrl {
    return when(
      image: (image) => image.url,
      video: (video) => video.sources.isNotEmpty ? video.sources.first.url : '',
      orElse: () => '',
    );
  }
}

/// Represents an image media asset.
class MediaImage extends Media {
  /// The network URL locating the image resource.
  final String url;

  const MediaImage({required this.url, super.alt})
    : super(mediaContentType: MediaContentType.image);
}

/// Represents a video media asset containing multiple format encodings.
final class MediaVideo extends Media {
  /// The available video sources in different format encodings.
  final List<VideoSource> sources;

  /// Optional preview image to display before video playback begins.
  final MediaImage? previewImage;

  const MediaVideo({
    required super.alt,
    required this.sources,
    this.previewImage,
  }) : super(mediaContentType: MediaContentType.video);
}

/// Defines a specific format and location for a video encoding.
class VideoSource {
  final VideoFormat format;

  /// The MIME type of the video source (e.g., "video/mp4").
  final String mimeType;

  /// The network URL locating the video resource.
  final String url;

  const VideoSource({
    required this.format,
    required this.mimeType,
    required this.url,
  });
}

/// Defines the supported video container formats.
enum VideoFormat { mp4, webm, unknown }
