import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/data/services/queries/search/search.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final brandRepositoryProvider = Provider<ISearchRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return SearchRepository(client);
});

final searchSuggestionsProvider =
    FutureProvider.family<Query$GetSuggestions$suggestion?, String>((
      ref,
      term,
    ) async {
      final repository = ref.watch(brandRepositoryProvider);
      return repository.getSuggestions(term);
    });

abstract class ISearchRepository {
  Future<Query$GetSuggestions$suggestion?> getSuggestions(String term);
}

class SearchRepository implements ISearchRepository {
  final GraphQLClient _client;

  SearchRepository(this._client);

  @override
  Future<Query$GetSuggestions$suggestion?> getSuggestions(String term) {
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
