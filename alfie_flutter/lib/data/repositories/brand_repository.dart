import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/brand_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/brands.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provides the active [IBrandRepository] instance for catalog data retrieval.
final graphQLBrandRepositoryProvider = Provider<IBrandRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLBrandRepository(client);
});

/// Orchestrates the asynchronous fetching and caching of the catalog's [Brand] list.
///
/// Consumed by UI layers to display brand filters or directory listings.
final brandListProvider = FutureProvider<List<Brand>>((ref) async {
  final repository = ref.watch(graphQLBrandRepositoryProvider);
  return repository.getBrands();
});

/// Contract for domain-level brand catalog operations.
abstract interface class IBrandRepository {
  /// Retrieves the complete list of associated [Brand] entities available in the catalog.
  Future<List<Brand>> getBrands();
}

/// GraphQL-based implementation of [IBrandRepository].
///
/// Executes queries using [GraphQLExecutor] and maps the raw DTO fragments
/// into pure domain models via mapper extensions.
final class GraphQLBrandRepository implements IBrandRepository {
  final GraphQLClient _client;

  GraphQLBrandRepository(this._client);

  @override
  Future<List<Brand>> getBrands() async {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$Brands(
        Options$Query$Brands(fetchPolicy: globalFetchPolicy),
      ),
      parseData: (data) {
        return data.brands.map((fragment) => fragment.toDomain()).toList();
      },
    );
  }
}
