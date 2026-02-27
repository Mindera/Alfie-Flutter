import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/hive_adapters/search_item_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _boxName = 'searchBox';
  static const String _historyKey = 'recentSearches';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SearchItemAdapter());
    await Hive.openBox<List<dynamic>>(_boxName);
  }

  Box<List<dynamic>> get _box => Hive.box<List<dynamic>>(_boxName);

  List<SearchItem> getSearchHistory() {
    final data = _box.get(_historyKey, defaultValue: []);
    return data?.cast<SearchItem>() ?? [];
  }

  Future<void> saveSearchHistory(List<SearchItem> history) async {
    await _box.put(_historyKey, history);
  }
}

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());
