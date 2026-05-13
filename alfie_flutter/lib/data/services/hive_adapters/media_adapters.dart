import 'package:alfie_flutter/data/models/media.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] for binary serialization of the [MediaContentType] enum.
class MediaContentTypeAdapter extends TypeAdapter<MediaContentType> {
  /// The unique identifier for this type within Hive.
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

/// A Hive [TypeAdapter] for binary serialization of the [VideoFormat] enum.
class VideoFormatAdapter extends TypeAdapter<VideoFormat> {
  /// The unique identifier for this type within Hive.
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

/// A Hive [TypeAdapter] for binary serialization of [MediaImage] entities.
class MediaImageAdapter extends TypeAdapter<MediaImage> {
  /// The unique identifier for this type within Hive.
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

/// A Hive [TypeAdapter] for binary serialization of [VideoSource] entities.
class VideoSourceAdapter extends TypeAdapter<VideoSource> {
  /// The unique identifier for this type within Hive.
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

/// A Hive [TypeAdapter] for binary serialization of [MediaVideo] entities.
class MediaVideoAdapter extends TypeAdapter<MediaVideo> {
  /// The unique identifier for this type within Hive.
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
