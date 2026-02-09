import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/brand_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/brands.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provider for the [GraphQLBrandRepository] instance.
///
/// This manages the lifecycle of the repository and injects the GraphQL client.
final graphQLBrandRepositoryProvider = Provider<IBrandRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLBrandRepository(client);
});

/// Provider that fetches and caches the list of brands.
///
/// Results are cached to avoid redundant network requests.
final brandListProvider = FutureProvider<List<Brand>>((ref) async {
  final repository = ref.watch(graphQLBrandRepositoryProvider);
  return repository.getBrands();
});

/// Contract for brand data operations.
abstract class IBrandRepository {
  /// Fetches all available brands.
  Future<List<Brand>> getBrands();
}

/// Implementation of [IBrandRepository] using GraphQL.
///
/// Uses cache-first strategy to optimize performance and reduce network calls.
class GraphQLBrandRepository implements IBrandRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  GraphQLBrandRepository(this._client);

  @override
  Future<List<Brand>> getBrands() async {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$Brands(
        Options$Query$Brands(fetchPolicy: FetchPolicy.cacheFirst),
      ),
      parseData: (data) {
        return data.brands.map((fragment) => fragment.toDomain()).toList();
      },
    );
  }
}
