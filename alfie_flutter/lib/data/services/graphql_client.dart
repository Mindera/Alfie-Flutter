import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gqlClientProvider = Provider<GraphQLClient>((ref) {
  // Use http://10.0.2.2:4000/ if testing on an Android Emulator
  final HttpLink httpLink = HttpLink('http://localhost:4000/');

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );
});
