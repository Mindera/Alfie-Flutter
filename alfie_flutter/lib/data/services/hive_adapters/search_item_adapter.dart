import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:hive/hive.dart';

/// A Hive [TypeAdapter] that handles binary serialization for [SearchItem].
///
/// This allows the repository to persist search history directly to local
/// storage.
class SearchItemAdapter extends TypeAdapter<SearchItem> {
  /// The unique identifier for this type within Hive.
  /// Keep this constant to avoid data corruption during migrations.
  @override
  final int typeId = 0;

  @override
  SearchItem read(BinaryReader reader) {
    return SearchItem(
      query: reader.readString(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, SearchItem obj) {
    writer.writeString(obj.query);
    writer.writeInt(obj.timestamp.millisecondsSinceEpoch);
  }
}
