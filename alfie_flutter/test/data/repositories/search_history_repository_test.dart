import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockPersistentStorageService mockStorageService;
  late SearchHistoryRepository repository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(<SearchItem>[]);
  });

  setUp(() {
    mockStorageService = MockPersistentStorageService();

    container = ProviderContainer(
      overrides: [
        persistentStorageServiceProvider.overrideWithValue(mockStorageService),
      ],
    );

    repository = container.read(searchHistoryRepositoryProvider);

    // Default stub to return empty history
    when(() => mockStorageService.getSearchHistory()).thenReturn([]);
    when(
      () => mockStorageService.saveSearchHistory(any()),
    ).thenAnswer((_) async {});
  });

  tearDown(() {
    container.dispose();
  });

  group('SearchHistoryRepository Tests - ', () {
    test('getRecentSearches returns list from persistent storage', () {
      final history = [SearchItem(query: 'Shoes', timestamp: DateTime.now())];
      when(() => mockStorageService.getSearchHistory()).thenReturn(history);

      final result = repository.getRecentSearches();

      expect(result, equals(history));
      verify(() => mockStorageService.getSearchHistory()).called(1);
    });

    test('addSearchQuery inserts new item at the top (index 0)', () async {
      await repository.addSearchQuery('Shirts');

      verify(
        () => mockStorageService.saveSearchHistory(
          any(
            that: predicate<List<SearchItem>>(
              (list) => list.length == 1 && list.first.query == 'Shirts',
            ),
          ),
        ),
      ).called(1);
    });

    test(
      'addSearchQuery handles deduplication by moving existing query to top',
      () async {
        final existingHistory = [
          SearchItem(
            query: 'Pants',
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          SearchItem(
            query: 'Shoes',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          ),
        ];
        when(
          () => mockStorageService.getSearchHistory(),
        ).thenReturn(existingHistory);

        // Re-adding 'Shoes' should move it to index 0
        await repository.addSearchQuery('Shoes');

        verify(
          () => mockStorageService.saveSearchHistory(
            any(
              that: predicate<List<SearchItem>>(
                (list) =>
                    list.length == 2 &&
                    list.first.query == 'Shoes' &&
                    list.last.query == 'Pants',
              ),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'addSearchQuery maintains maximum storage limit of 10 items',
      () async {
        // Create 10 existing items
        final fullHistory = List.generate(
          10,
          (i) => SearchItem(query: 'Item $i', timestamp: DateTime.now()),
        );
        when(
          () => mockStorageService.getSearchHistory(),
        ).thenReturn(fullHistory);

        await repository.addSearchQuery('New Item');

        verify(
          () => mockStorageService.saveSearchHistory(
            any(
              that: predicate<List<SearchItem>>(
                (list) =>
                    list.length == 10 &&
                    list.first.query == 'New Item' &&
                    !list.any((item) => item.query == 'Item 9'),
              ),
            ), // Last item should be removed
          ),
        ).called(1);
      },
    );

    test(
      'removeSearch deletes query using case-insensitive matching',
      () async {
        final history = [
          SearchItem(query: 'Jackets', timestamp: DateTime.now()),
          SearchItem(query: 'Hats', timestamp: DateTime.now()),
        ];
        when(() => mockStorageService.getSearchHistory()).thenReturn(history);

        // Remove using different casing
        await repository.removeSearch('  JACKETS  ');

        verify(
          () => mockStorageService.saveSearchHistory(
            any(
              that: predicate<List<SearchItem>>(
                (list) => list.length == 1 && list.first.query == 'Hats',
              ),
            ),
          ),
        ).called(1);
      },
    );

    test('removeSearch does not call save if query is not found', () async {
      when(() => mockStorageService.getSearchHistory()).thenReturn([]);

      await repository.removeSearch('NonExistent');

      verifyNever(() => mockStorageService.saveSearchHistory(any()));
    });

    test('clearAll saves an empty list to storage', () async {
      await repository.clearAll();

      verify(() => mockStorageService.saveSearchHistory([])).called(1);
    });
  });
}
