enum MediaContentType { image, video, unknown }

class Media {
  final String? alt;
  final MediaContentType mediaContentType;

  Media({this.alt, required this.mediaContentType});
}

class MediaImage extends Media {
  final String url;

  MediaImage({required this.url, super.alt})
    : super(mediaContentType: MediaContentType.image);
}

class MediaVideo extends Media {
  final List<VideoSource> sources;

  final MediaImage? previewImage;

  MediaVideo({required super.alt, required this.sources, this.previewImage})
    : super(mediaContentType: MediaContentType.video);
}

class VideoSource {
  final VideoFormat format;
  final String mimeType;
  final String url;

  VideoSource({
    required this.format,
    required this.mimeType,
    required this.url,
  });
}

enum VideoFormat { mp4, webm, unknown }
