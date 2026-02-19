import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Provides a configured [GraphQLClient] instance for making GraphQL queries.
///
/// The client is configured with:
/// - HTTP link pointing to the GraphQL server URL from [Environment]
/// - Hive-based cache for offline support and performance optimization
///
/// Note: When testing on Android Emulator, the server URL should be
/// `http://10.0.2.2:4000/` to access the host machine's localhost.
final gqlClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink(Environment.instance.graphqlServerUrl);

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore(), possibleTypes: possibleTypesMap),
  );
});

/// Uses a cache-first strategy to minimize network requests and improve performance.
final globalFetchPolicy = FetchPolicy.cacheFirst;
