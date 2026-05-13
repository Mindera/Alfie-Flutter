import 'package:alfie_flutter/data/models/suggestion.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/suggestion_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provides the active [ISearchRepository] implementation.
final graphQLSearchRepositoryProvider = Provider<ISearchRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLSearchRepository(client);
});

/// Orchestrates the asynchronous fetching of [Suggestion]s based on user input.
///
/// The [term] parameter uniquely identifies the query, allowing Riverpod to
/// natively cache results for previously searched terms.
final searchSuggestionsProvider = FutureProvider.family<Suggestion, String>((
  ref,
  term,
) async {
  final repository = ref.watch(graphQLSearchRepositoryProvider);
  return repository.getSuggestions(term);
});

/// Contract for domain-level search autocomplete operations.
abstract interface class ISearchRepository {
  /// Retrieves auto-complete suggestions and matching entities for the given [term].
  Future<Suggestion> getSuggestions(String term);
}

/// GraphQL-based implementation of [ISearchRepository].
///
/// Executes network requests via [GraphQLExecutor] and maps the raw DTO fragments
/// into pure domain models to insulate the application from network contracts.
final class GraphQLSearchRepository implements ISearchRepository {
  final GraphQLClient _client;

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
