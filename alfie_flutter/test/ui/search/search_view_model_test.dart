import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/ui/search/view_model/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a Mock class for the repository
class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

void main() {
  late MockSearchHistoryRepository mockRepository;
  late ProviderContainer container;

  // Helper to create a list of search items
  List<SearchItem> createSearchItems(int count) {
    return List.generate(
      count,
      (i) => SearchItem(
        query: 'Query $i',
        timestamp: DateTime.now().subtract(Duration(minutes: i)),
      ),
    );
  }

  setUp(() {
    mockRepository = MockSearchHistoryRepository();

    // Initialize the container and override the repository provider
    container = ProviderContainer(
      overrides: [
        searchHistoryRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    // Standard stub for getting recent searches
    when(() => mockRepository.getRecentSearches()).thenReturn([]);
  });

  tearDown(() {
    container.dispose();
  });

  group('SearchViewModel Tests - ', () {
    test('initial state is correct and fetches recent searches', () {
      final initialItems = createSearchItems(3);
      when(() => mockRepository.getRecentSearches()).thenReturn(initialItems);

      // Trigger build() by reading the provider
      final state = container.read(searchViewModelProvider);

      expect(state.currentSearchQuery, isNull);
      expect(state.recentSearches, initialItems);
      verify(() => mockRepository.getRecentSearches()).called(1);
    });

    test('recentSearches respects maxSearchItemsPresented limit (5)', () {
      final manyItems = createSearchItems(10);
      when(() => mockRepository.getRecentSearches()).thenReturn(manyItems);

      final state = container.read(searchViewModelProvider);

      expect(state.recentSearches.length, 5);
      expect(state.recentSearches.first.query, 'Query 0');
    });

    test('submitSearch adds query and updates state', () async {
      const query = ' Flutter ';
      final expectedQuery = 'Flutter';

      when(
        () => mockRepository.addSearchQuery(expectedQuery),
      ).thenAnswer((_) async => {});
      when(() => mockRepository.getRecentSearches()).thenReturn([
        SearchItem(query: expectedQuery, timestamp: DateTime.now()),
      ]);

      await container
          .read(searchViewModelProvider.notifier)
          .submitSearch(query);

      final state = container.read(searchViewModelProvider);
      expect(state.currentSearchQuery, expectedQuery);
      expect(state.recentSearches.first.query, expectedQuery);
      verify(() => mockRepository.addSearchQuery(expectedQuery)).called(1);
    });

    test('submitSearch does nothing if query is empty or whitespace', () async {
      await container
          .read(searchViewModelProvider.notifier)
          .submitSearch('   ');

      verifyNever(() => mockRepository.addSearchQuery(any()));
    });

    test('removeSearch calls repository and refreshes list', () async {
      const queryToRemove = 'Dart';
      when(
        () => mockRepository.removeSearch(queryToRemove),
      ).thenAnswer((_) async => {});

      await container
          .read(searchViewModelProvider.notifier)
          .removeSearch(queryToRemove);

      verify(() => mockRepository.removeSearch(queryToRemove)).called(1);
      verify(() => mockRepository.getRecentSearches()).called(greaterThan(0));
    });

    test('clearHistory calls repository and resets list', () async {
      when(() => mockRepository.clearAll()).thenAnswer((_) async => {});
      when(() => mockRepository.getRecentSearches()).thenReturn([]);

      await container.read(searchViewModelProvider.notifier).clearHistory();

      final state = container.read(searchViewModelProvider);
      expect(state.recentSearches, isEmpty);
      verify(() => mockRepository.clearAll()).called(1);
    });
  });
}
