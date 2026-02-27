import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:hive/hive.dart';

class SearchItemAdapter extends TypeAdapter<SearchItem> {
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
