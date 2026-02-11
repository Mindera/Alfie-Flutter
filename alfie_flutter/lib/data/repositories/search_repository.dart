import 'package:alfie_flutter/data/models/suggestion.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/suggestion_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provider for the [GraphQLSearchRepository] instance.
///
/// Manages the lifecycle of the search repository and injects the GraphQL client dependency.
final graphQLSearchRepositoryProvider = Provider<ISearchRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLSearchRepository(client);
});

/// Provider that fetches and caches search suggestions for a given search term.
final searchSuggestionsProvider = FutureProvider.family<Suggestion, String>((
  ref,
  term,
) async {
  final repository = ref.watch(graphQLSearchRepositoryProvider);
  return repository.getSuggestions(term);
});

/// Contract for search data operations.
abstract interface class ISearchRepository {
  /// Fetches search suggestions for the given [term]
  Future<Suggestion> getSuggestions(String term);
}

/// Implementation of [ISearchRepository] using GraphQL.
///
/// Transforms GraphQL response data into domain models using mapper extensions.
final class GraphQLSearchRepository implements ISearchRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  GraphQLSearchRepository(this._client);

  @override
  Future<Suggestion> getSuggestions(String term) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetSuggestions(
        Options$Query$GetSuggestions(
          variables: Variables$Query$GetSuggestions(term: term),
          fetchPolicy: globalFetchPolicy,
        ),
      ),
      parseData: (data) => data.suggestion.toDomain(),
    );
  }
}
