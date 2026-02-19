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

  /// Creates a new [Media] instance.
  Media({this.alt, required this.mediaContentType});

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
}

/// Represents image media content.
///
/// An image media asset with a URL pointing to the image resource.
final class MediaImage extends Media {
  /// The URL to access the image resource.
  final String url;

  /// Creates a new [MediaImage] instance.
  MediaImage({required this.url, super.alt})
    : super(mediaContentType: MediaContentType.image);
}

/// Represents video media content.
///
/// A video media asset with one or more sources in different formats
/// and an optional preview image.
final class MediaVideo extends Media {
  /// The list of video sources available in different formats.
  final List<VideoSource> sources;

  /// Optional preview image displayed before the video plays.
  final MediaImage? previewImage;

  /// Creates a new [MediaVideo] instance.
  MediaVideo({required super.alt, required this.sources, this.previewImage})
    : super(mediaContentType: MediaContentType.video);
}

/// Represents a video source with a specific format.
///
/// Contains the format, MIME type, and URL for a single video encoding variant.
/// Multiple sources in different formats allow the client to choose
/// the best option based on platform capabilities.
final class VideoSource {
  /// The video format/container type (e.g., MP4, WebM).
  final VideoFormat format;

  /// The MIME type of the video source (e.g., "video/mp4").
  final String mimeType;

  /// The URL to access the video resource.
  final String url;

  /// Creates a new [VideoSource] instance.
  VideoSource({
    required this.format,
    required this.mimeType,
    required this.url,
  });
}

/// Defines the supported video formats.
enum VideoFormat { mp4, webm, unknown }
