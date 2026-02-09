import 'package:alfie_flutter/data/services/graphql_client.dart';

import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';

/// Provider for the [SearchRepository] instance.
///
/// This manages the lifecycle of the repository and injects the GraphQL client.
final searchRepositoryProvider = Provider<ISearchRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return SearchRepository(client);
});

/// Provider that fetches search suggestions for a given search term.
///
/// Results are cached to avoid redundant network requests for the same term.
final searchSuggestionsProvider =
    FutureProvider.family<Query$GetSuggestions$suggestion?, String>((
      ref,
      term,
    ) async {
      final repository = ref.watch(searchRepositoryProvider);
      return repository.getSuggestions(term);
    });

/// Contract for search data operations.
abstract class ISearchRepository {
  /// Fetches search suggestions for the given [term].
  ///
  /// Results are cached using the GraphQL client's cache-first policy.
  Future<Query$GetSuggestions$suggestion> getSuggestions(String term);
}

/// Implementation of [ISearchRepository] using GraphQL.
class SearchRepository implements ISearchRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  SearchRepository(this._client);

  @override
  Future<Query$GetSuggestions$suggestion> getSuggestions(String term) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetSuggestions(
        Options$Query$GetSuggestions(
          variables: Variables$Query$GetSuggestions(term: term),
          fetchPolicy: FetchPolicy.cacheFirst,
        ),
      ),
      parseData: (data) => data.suggestion,
    );
  }
}
