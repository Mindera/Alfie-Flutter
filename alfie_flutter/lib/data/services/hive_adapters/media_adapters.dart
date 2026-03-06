import 'package:alfie_flutter/data/models/media.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [MediaContentType].
class MediaContentTypeAdapter extends TypeAdapter<MediaContentType> {
  @override
  final int typeId = 5;

  @override
  MediaContentType read(BinaryReader reader) {
    return MediaContentType.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, MediaContentType obj) {
    writer.writeInt(obj.index);
  }
}

/// A Hive [TypeAdapter] that handles binary serialization for [VideoFormat].
class VideoFormatAdapter extends TypeAdapter<VideoFormat> {
  @override
  final int typeId = 6;

  @override
  VideoFormat read(BinaryReader reader) {
    return VideoFormat.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, VideoFormat obj) {
    writer.writeInt(obj.index);
  }
}

/// A Hive [TypeAdapter] that handles binary serialization for [MediaImage].
class MediaImageAdapter extends TypeAdapter<MediaImage> {
  @override
  final int typeId = 7;

  @override
  MediaImage read(BinaryReader reader) {
    return MediaImage(url: reader.readString(), alt: reader.read() as String?);
  }

  @override
  void write(BinaryWriter writer, MediaImage obj) {
    writer.writeString(obj.url);
    writer.write(obj.alt);
  }
}

/// A Hive [TypeAdapter] that handles binary serialization for [VideoSource].
class VideoSourceAdapter extends TypeAdapter<VideoSource> {
  @override
  final int typeId = 8;

  @override
  VideoSource read(BinaryReader reader) {
    return VideoSource(
      format: reader.read() as VideoFormat,
      mimeType: reader.readString(),
      url: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoSource obj) {
    writer.write(obj.format);
    writer.writeString(obj.mimeType);
    writer.writeString(obj.url);
  }
}

/// A Hive [TypeAdapter] that handles binary serialization for [MediaVideo].
class MediaVideoAdapter extends TypeAdapter<MediaVideo> {
  @override
  final int typeId = 9;

  @override
  MediaVideo read(BinaryReader reader) {
    return MediaVideo(
      alt: reader.read() as String?,
      sources: (reader.read() as List).cast<VideoSource>(),
      previewImage: reader.read() as MediaImage?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaVideo obj) {
    writer.write(obj.alt);
    writer.write(obj.sources);
    writer.write(obj.previewImage);
  }
}
