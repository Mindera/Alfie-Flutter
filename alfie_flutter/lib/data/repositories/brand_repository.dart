import 'dart:async';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/data/services/queries/brands/brands.graphql.dart';
import 'package:alfie_flutter/data/services/queries/brands/fragments/brand_fragment.graphql.dart';
import 'package:alfie_flutter/utils/error/graphql_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final brandRepositoryProvider = Provider<IBrandRepository>((ref) {
  final client = ref.watch(gqlClientProvider);
  return BrandRepository(client);
});

final brandListProvider = FutureProvider<List<Fragment$BrandFragment>>((
  ref,
) async {
  final repository = ref.watch(brandRepositoryProvider);
  return repository.getBrands();
});

abstract class IBrandRepository {
  Future<List<Fragment$BrandFragment>> getBrands();
}

class BrandRepository implements IBrandRepository {
  final GraphQLClient _client;

  BrandRepository(this._client);

  @override
  Future<List<Fragment$BrandFragment>> getBrands() async {
    return GraphQLExecutor.execute(
      performQuery: () => _client.query$Brands(
        Options$Query$Brands(
          fetchPolicy: FetchPolicy
              .cacheFirst, // Only fetch from network if cached result is not available.
        ),
      ),
      parseData: (data) => data.brands,
    );
  }
}
