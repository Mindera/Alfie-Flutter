import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/fragments/brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/brands.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provider for the [BrandRepository] instance.
///
/// This manages the lifecycle of the repository and injects the GraphQL client.
final brandRepositoryProvider = Provider<IBrandRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return BrandRepository(client);
});

/// Provider that fetches and caches the list of brands.
///
/// Results are cached to avoid redundant network requests.
final brandListProvider = FutureProvider<List<Fragment$BrandFragment>>((
  ref,
) async {
  final repository = ref.watch(brandRepositoryProvider);
  return repository.getBrands();
});

/// Contract for brand data operations.
abstract class IBrandRepository {
  /// Fetches all available brands.
  ///
  /// Results are cached using the GraphQL client's cache-first policy.
  Future<List<Fragment$BrandFragment>> getBrands();
}

/// Implementation of [IBrandRepository] using GraphQL.
class BrandRepository implements IBrandRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  BrandRepository(this._client);

  @override
  Future<List<Fragment$BrandFragment>> getBrands() async {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$Brands(
        Options$Query$Brands(fetchPolicy: FetchPolicy.cacheFirst),
      ),
      parseData: (data) => data.brands,
    );
  }
}
