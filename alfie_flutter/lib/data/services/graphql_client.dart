import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/graphql/generated/schema.graphql.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Orchestrates the global [GraphQLClient] for network communications.
///
/// Configures the transport layer using [Environment.graphqlServerUrl] and
/// leverages a [HiveStore] cache for local data persistence and offline capabilities.
///
/// *Engineering Note:* When testing on an Android Emulator, ensure the environment
/// URL points to `http://10.0.2.2:<port>` to properly route to the host machine's localhost.
final gqlClientProvider = Provider<GraphQLClient>((ref) {
  final HttpLink httpLink = HttpLink(
    ref.watch(environmentProvider).graphqlServerUrl,
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore(), possibleTypes: possibleTypesMap),
  );
});

/// The default [FetchPolicy] applied across repository network requests.
///
/// Prioritizes the local [GraphQLCache] to minimize latency and reduce backend load,
/// falling back to the network only when data is missing or stale.
final globalFetchPolicy = FetchPolicy.cacheFirst;
