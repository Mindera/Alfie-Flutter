import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/extensions/product_listing_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/product_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provides the active [IProductRepository] instance for catalog data retrieval.
final graphQLRepositoryProvider = Provider<IProductRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return GraphQLProductRepository(client);
});

/// Orchestrates the asynchronous fetching and caching of a single [Product].
///
/// Automatically invalidates and refetches when [productId] changes.
final getProductProvider = FutureProvider.family<Product?, String>((
  ref,
  productId,
) async {
  final repository = ref.watch(graphQLRepositoryProvider);
  return repository.getProduct(productId);
});

/// Orchestrates the asynchronous fetching of [ProductListing]s based on supplied [ProductListingParams].
///
/// Consumed by collection pages and search result views.
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

/// Contract for domain-level product catalog operations.
abstract interface class IProductRepository {
  /// Fetches a specific [Product] by its internal catalog [id].
  ///
  /// Returns `null` if the item does not exist or is unpublished.
  Future<Product?> getProduct(String id);

  /// Fetches a paginated result set of products constrained by the provided parameters.
  Future<ProductListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    ProductListingSort? sort,
  });
}

/// GraphQL-based implementation of [IProductRepository].
///
/// Executes queries via [GraphQLExecutor] and maps the raw DTO fragments
/// into pure domain models to insulate the application from network layer contracts.
final class GraphQLProductRepository implements IProductRepository {
  final GraphQLClient _client;

  GraphQLProductRepository(this._client);

  @override
  Future<Product?> getProduct(String id) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetProduct(
        Options$Query$GetProduct(
          variables: Variables$Query$GetProduct(productId: id),
          fetchPolicy: globalFetchPolicy,
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
          fetchPolicy: globalFetchPolicy,
        ),
      ),
      parseData: (data) => data.productListing?.toDomain(),
    );
  }
}

/// Encapsulates filtering, sorting, and pagination state into a single query object.
///
/// Facilitates caching and identity comparison within [getProductListingProvider].
final class ProductListingParams {
  final int offset;
  final int limit;
  final String? categoryId;
  final String? query;
  final ProductListingSort? sort;

  ProductListingParams({
    this.offset = 0,
    this.limit = 10,
    this.categoryId,
    this.query,
    this.sort,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductListingParams &&
        other.offset == offset &&
        other.limit == limit &&
        other.categoryId == categoryId &&
        other.query == query &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return Object.hash(offset, limit, categoryId, query, sort);
  }

  ProductListingParams copyWith({
    int? offset,
    int? limit,
    String? categoryId,
    String? query,
    ProductListingSort? sort,
  }) {
    return ProductListingParams(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      categoryId: categoryId ?? this.categoryId,
      query: query ?? this.query,
      sort: sort ?? this.sort,
    );
  }
}
