import 'dart:async';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/data/services/queries/products/fragments/product_fragment.graphql.dart';
import 'package:alfie_flutter/data/services/queries/products/products.graphql.dart';
import 'package:alfie_flutter/data/services/schema.graphql.dart';
import 'package:alfie_flutter/utils/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return ProductRepository(client);
});

final getProductProvider =
    FutureProvider.family<Fragment$ProductFragment?, String>((
      ref,
      productId,
    ) async {
      final repository = ref.watch(productRepositoryProvider);
      return repository.getProduct(productId);
    });

abstract class IProductRepository {
  Future<Fragment$ProductFragment?> getProduct(String id);
  Future<Query$ProductListingQuery$productListing?> getProductListing({
    required int offset,
    required int limit,
    String? categoryId,
    String? query,
    Enum$ProductListingSort? sort,
  });
}

class ProductRepository implements IProductRepository {
  final GraphQLClient _client;

  ProductRepository(this._client);

  @override
  Future<Fragment$ProductFragment?> getProduct(String id) {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$GetProduct(
        Options$Query$GetProduct(
          variables: Variables$Query$GetProduct(productId: id),
          fetchPolicy: FetchPolicy
              .cacheFirst, // Only fetch from network if cached result is not available.
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
