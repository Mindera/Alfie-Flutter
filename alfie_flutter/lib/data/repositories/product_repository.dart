import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/data/services/queries/products/fragments/product_fragment.graphql.dart';
import 'package:alfie_flutter/data/services/queries/products/products.graphql.dart';
import 'package:alfie_flutter/data/services/schema.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provider for the [ProductRepository] instance.
///
/// This manages the lifecycle of the repository and injects the GraphQL client.
final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return ProductRepository(client);
});

/// Provider that fetches a single product by its ID.
///
/// Results are cached to avoid redundant network requests for the same product.
final getProductProvider =
    FutureProvider.family<Fragment$ProductFragment?, String>((
      ref,
      productId,
    ) async {
      final repository = ref.watch(productRepositoryProvider);
      return repository.getProduct(productId);
    });

/// Contract for product data operations.
abstract class IProductRepository {
  /// Fetches a single product by its ID.
  ///
  /// Returns `null` if the product is not found.
  /// Results are cached using the GraphQL client's cache-first policy.
  Future<Fragment$ProductFragment?> getProduct(String id);

  /// Fetches a paginated list of products with optional filtering and sorting.
  ///
  /// Parameters:
  /// - [offset]: The number of products to skip (for pagination).
  /// - [limit]: The maximum number of products to return per page.
  /// - [categoryId]: Optional filter to show only products in a specific category.
  /// - [query]: Optional search query to filter products by name or description.
  /// - [sort]: Optional sorting order for the product listing.
  ///
  /// Returns `null` if the product listing is not available.
  Future<Query$ProductListingQuery$productListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  });
}

/// Implementation of [IProductRepository] using GraphQL.
class ProductRepository implements IProductRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  ProductRepository(this._client);

  @override
  Future<Fragment$ProductFragment?> getProduct(String id) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetProduct(
        Options$Query$GetProduct(
          variables: Variables$Query$GetProduct(productId: id),
          fetchPolicy: FetchPolicy.cacheFirst,
        ),
      ),
      parseData: (data) => data.product,
    );
  }

  @override
  Future<Query$ProductListingQuery$productListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  }) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$ProductListingQuery(
        Options$Query$ProductListingQuery(
          variables: Variables$Query$ProductListingQuery(
            offset: offset,
            limit: limit,
            categoryId: categoryId,
            query: query,
            sort: sort,
          ),
        ),
      ),
      parseData: (data) => data.productListing,
    );
  }
}
