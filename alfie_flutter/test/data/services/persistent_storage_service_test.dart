import 'dart:io';

import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

// --- Mock Adapters ---
// Hive requires adapters to serialize custom objects. By creating mock adapters,
// we can safely save Mock objects into the real Hive boxes during testing
// without needing to import or trigger the real domain adapters.
class MockSearchItemAdapter extends Mock
    implements TypeAdapter<MockSearchItem> {
  @override
  final int typeId = 100; // Unique typeId for this mock adapter

  @override
  MockSearchItem read(BinaryReader reader) {
    // Return a simple MockSearchItem instance when Hive reads from the box
    return MockSearchItem();
  }

  @override
  void write(BinaryWriter writer, MockSearchItem obj) {
    // No actual data needs to be written for the mock, so this can be empty
  }
}

class MockBagItemAdapter extends TypeAdapter<MockBagItem> {
  @override
  final int typeId = 101;
  @override
  MockBagItem read(BinaryReader reader) => MockBagItem();
  @override
  void write(BinaryWriter writer, MockBagItem obj) {}
}

class MockProductAdapter extends TypeAdapter<MockProduct> {
  @override
  final int typeId = 102;
  @override
  MockProduct read(BinaryReader reader) => MockProduct();
  @override
  void write(BinaryWriter writer, MockProduct obj) {}
}

void main() {
  late HiveService service;
  late Directory tempDir;

  // Helper to safely open all boxes needed by the standard tests
  Future<void> openTestBoxes() async {
    Hive.init(tempDir.path);

    if (!Hive.isAdapterRegistered(100)) {
      Hive.registerAdapter(MockSearchItemAdapter());
    }
    if (!Hive.isAdapterRegistered(101)) {
      Hive.registerAdapter(MockBagItemAdapter());
    }
    if (!Hive.isAdapterRegistered(102)) {
      Hive.registerAdapter(MockProductAdapter());
    }

    await Hive.openBox<List<dynamic>>('recentSearchesBox');
    await Hive.openBox<List<dynamic>>('bagBox');
    await Hive.openBox<List<dynamic>>('wishlistBox');
    await Hive.openBox('preferencesBox');
    await Hive.openBox('authBox');
  }

  setUpAll(() async {
    // 1. Create the temp directory ONCE for the whole file
    tempDir = await Directory.systemTemp.createTemp('hive_test_dir');
    // 2. Open the boxes for the first time
    await openTestBoxes();
  });

  setUp(() {
    service = HiveService();
  });

  tearDown(() async {
    // Safely clear all boxes between tests to ensure test isolation
    if (Hive.isBoxOpen('recentSearchesBox')) {
      await Hive.box<List<dynamic>>('recentSearchesBox').clear();
    }
    if (Hive.isBoxOpen('bagBox')) {
      await Hive.box<List<dynamic>>('bagBox').clear();
    }
    if (Hive.isBoxOpen('wishlistBox')) {
      await Hive.box<List<dynamic>>('wishlistBox').clear();
    }
    if (Hive.isBoxOpen('preferencesBox')) {
      await Hive.box('preferencesBox').clear();
    }
    if (Hive.isBoxOpen('authBox')) {
      await Hive.box('authBox').clear();
    }
  });

  tearDownAll(() async {
    // Clean up Hive and the temporary directory after all tests finish
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('HiveService Init Tests - ', () {
    late Directory initTempDir;

    // Restores the global Hive state for the rest of the test file
    // after this specific group finishes destroying it.
    tearDownAll(() async {
      await openTestBoxes();
    });

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      initTempDir = await Directory.systemTemp.createTemp('hive_init_test');

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async {
              if (methodCall.method == 'getApplicationDocumentsDirectory') {
                return initTempDir.path;
              }
              return null;
            },
          );

      await Hive.close();
    });

    tearDown(() async {
      await Hive.close();
      if (initTempDir.existsSync()) {
        initTempDir.deleteSync(recursive: true);
      }
    });

    test(
      'init() initializes Flutter, registers adapters, and opens all boxes',
      () async {
        final initService = HiveService();

        await initService.init();

        expect(Hive.isBoxOpen('recentSearchesBox'), isTrue);
        expect(Hive.isBoxOpen('bagBox'), isTrue);
        expect(Hive.isBoxOpen('wishlistBox'), isTrue);
        expect(Hive.isBoxOpen('preferencesBox'), isTrue);
        expect(Hive.isBoxOpen('authBox'), isTrue);

        expect(Hive.isAdapterRegistered(0), isTrue);
        expect(Hive.isAdapterRegistered(15), isTrue);
      },
    );

    test('init() is idempotent (safe to call multiple times)', () async {
      final initService = HiveService();

      await initService.init();
      await initService.init();

      expect(Hive.isBoxOpen('authBox'), isTrue);
      expect(Hive.isAdapterRegistered(0), isTrue);
    });
  });

  group('HiveService Search History Tests - ', () {
    test('getSearchHistory returns empty list by default', () {
      final result = service.getSearchHistory();
      expect(result, isEmpty);
    });

    test('saveSearchHistory persists data correctly', () async {
      final history = [MockSearchItem()];
      await service.saveSearchHistory(history);

      final result = service.getSearchHistory();

      expect(result.length, 1);
      expect(result.first, isA<MockSearchItem>());
    });
  });

  group('HiveService Bag Items Tests - ', () {
    test('getBagItems returns empty list by default', () {
      final result = service.getBagItems();
      expect(result, isEmpty);
    });

    test('saveBagItems persists data correctly', () async {
      final items = [MockBagItem(), MockBagItem()];
      await service.saveBagItems(items);

      final result = service.getBagItems();

      expect(result.length, 2);
      expect(result.first, isA<MockBagItem>());
    });
  });

  group('HiveService Wishlist Tests - ', () {
    test('getWishlist returns empty list by default', () {
      final result = service.getWishlist();
      expect(result, isEmpty);
    });

    test('saveWishlist persists data correctly', () async {
      final products = [MockProduct()];
      await service.saveWishlist(products);

      final result = service.getWishlist();

      expect(result.length, 1);
      expect(result.first, isA<MockProduct>());
    });
  });

  group('HiveService PLP Layout Preference Tests - ', () {
    test('getPlpLayoutPreference returns null by default', () {
      final result = service.getPlpLayoutPreference();
      expect(result, isNull);
    });

    test('savePlpLayoutPreference persists integer preference', () async {
      await service.savePlpLayoutPreference(2);

      final result = service.getPlpLayoutPreference();
      expect(result, equals(2));
    });
  });

  group('HiveService Access Token Tests - ', () {
    test('getAccessToken returns null by default', () {
      final result = service.getAccessToken();
      expect(result, isNull);
    });

    test('saveAccessToken persists token string', () async {
      await service.saveAccessToken('test_jwt_token');

      final result = service.getAccessToken();
      expect(result, equals('test_jwt_token'));
    });

    test('deleteAccessToken removes the token from storage', () async {
      await service.saveAccessToken('test_jwt_token');
      expect(service.getAccessToken(), isNotNull);

      await service.deleteAccessToken();

      expect(service.getAccessToken(), isNull);
    });
  });

  group('PersistentStorageServiceProvider Test - ', () {
    test('provider creates an instance of HiveService', () {
      final container = ProviderContainer();
      final providedService = container.read(persistentStorageServiceProvider);

      expect(providedService, isA<HiveService>());
      container.dispose();
    });
  });
}
