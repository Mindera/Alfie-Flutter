import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:alfie_flutter/ui/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';

import 'package:alfie_flutter/ui/search/view/default_search_body.dart';
import 'package:alfie_flutter/ui/search/view/search_suggestions.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_view.dart';

/// 1. Mock the Repository, NOT the Notifier.
/// This prevents Riverpod Notifier lifecycle errors.
class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

void main() {
  late MockSearchHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockSearchHistoryRepository();

    // Set up default stubs for the repository
    when(() => mockRepository.getRecentSearches()).thenReturn(<SearchItem>[]);
  });

  /// Helper method to build the widget under test with required wrappers
  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        // Inject the mock repository so the real SearchViewModel uses it
        searchHistoryRepositoryProvider.overrideWithValue(mockRepository),

        // NOTE: If ProductListingView or other child widgets depend on
        // other providers, you must override them here with mocks as well.
      ],
      child: Consumer(
        builder: (context, ref, child) {
          final theme = ref.watch(themeProvider);
          return MaterialApp(theme: theme, home: SearchScreen());
        },
      ),
    );
  }

  group('SearchScreen Widget Tests', () {
    testWidgets(
      'Shows DefaultSearchBody when the search query is completely empty',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verify Initial State
        expect(find.byType(DefaultSearchBody), findsOneWidget);
        expect(find.byType(SearchSuggestions), findsNothing);
        expect(find.byType(ProductListingView), findsNothing);
      },
    );

    testWidgets('Shows SearchSuggestions when typing but not yet submitted', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Find the inner TextField used by your Search widget and enter text
      // (Assuming your Custom Search widget uses a standard TextField under the hood)
      await tester.enterText(find.byType(TextField), 'sneakers');
      await tester.pump();

      // Verify Typing State
      expect(find.byType(SearchSuggestions), findsOneWidget);
      expect(find.byType(DefaultSearchBody), findsNothing);
      expect(find.byType(ProductListingView), findsNothing);
    });

    testWidgets(
      'Shows ProductListingView when the query is explicitly submitted',
      (tester) async {
        // Stub the repository method called during submission
        when(
          () => mockRepository.addSearchQuery(any()),
        ).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        // Enter text and simulate submitting the keyboard action
        await tester.enterText(find.byType(TextField), 'sneakers');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Verify Submitted State
        expect(find.byType(ProductListingView), findsOneWidget);
        expect(find.byType(SearchSuggestions), findsNothing);
        expect(find.byType(DefaultSearchBody), findsNothing);

        // Verify the repository was called to save the search history
        verify(() => mockRepository.addSearchQuery('sneakers')).called(1);
      },
    );
  });
}
