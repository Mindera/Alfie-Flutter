import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/product_listing_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provider for the [GraphQLProductRepository] instance.
///
/// Manages the lifecycle of the product repository and injects the GraphQL client dependency.
final graphQLRepositoryProvider = Provider<IProductRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLProductRepository(client);
});

/// Provider that fetches and caches a single product by its ID.
final getProductProvider = FutureProvider.family<Product?, String>((
  ref,
  productId,
) async {
  final repository = ref.watch(graphQLRepositoryProvider);
  return repository.getProduct(productId);
});

/// Provider that fetches and caches product listings with filtering and sorting.
final getProductListingProvider =
    FutureProvider.family<ProductListing?, ProductListingParams>((
      ref,
      params,
    ) async {
      final repository = ref.watch(graphQLRepositoryProvider);
      return repository.getProductListing(
        offset: params.offset,
        limit: params.limit,
        categoryId: params.categoryId,
        query: params.query,
        sort: params.sort,
      );
    });

/// Contract for product data operations.
abstract interface class IProductRepository {
  /// Fetches a single product by its ID, or `null` if not found.
  Future<Product?> getProduct(String id);

  /// Fetches a paginated list of products with optional filtering and sorting.
  Future<ProductListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    ProductListingSort? sort,
  });
}

/// Implementation of [IProductRepository] using GraphQL.
///
/// Transforms GraphQL response data into domain models using mapper extensions.
/// Uses cache-first strategy to minimize network requests.
final class GraphQLProductRepository implements IProductRepository {
  final GraphQLClient _client;

  /// Creates a new instance with the provided GraphQL [client].
  GraphQLProductRepository(this._client);

  @override
  Future<Product?> getProduct(String id) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetProduct(
        Options$Query$GetProduct(
          variables: Variables$Query$GetProduct(productId: id),
          fetchPolicy: FetchPolicy.cacheFirst,
        ),
      ),
      parseData: (data) => data.product?.toDomain(),
    );
  }

  @override
  Future<ProductListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    ProductListingSort? sort,
  }) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$ProductListingQuery(
        Options$Query$ProductListingQuery(
          variables: Variables$Query$ProductListingQuery(
            offset: offset,
            limit: limit,
            categoryId: categoryId,
            query: query,
            sort: sort?.toGraphQL(),
          ),
        ),
      ),
      parseData: (data) => data.productListing?.toDomain(),
    );
  }
}

/// Parameters for fetching a product listing.
///
/// Groups pagination, filtering, and sorting parameters
/// to be passed as a single argument to the provider.
final class ProductListingParams {
  /// The zero-based offset for pagination.
  final int offset;

  /// The maximum number of products per page.
  final int limit;

  /// Optional category filter.
  final String? categoryId;

  /// Optional search query for filtering products.
  final String? query;

  /// Optional sorting order for results.
  final ProductListingSort? sort;

  /// Creates a new [ProductListingParams] instance.
  ProductListingParams({
    required this.offset,
    required this.limit,
    this.categoryId,
    this.query,
    this.sort,
  });
}
