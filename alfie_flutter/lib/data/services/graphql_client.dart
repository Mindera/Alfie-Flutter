import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/data/services/queries/test.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gqlClientProvider = Provider<GraphQLClient>((ref) {
  // Use http://10.0.2.2:4000/ if testing on an Android Emulator
  final HttpLink httpLink = HttpLink(Environment.instance.graphqlServerUrl);

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );
});

final schemaTypesProvider = FutureProvider<List<Query$GetTest$__schema$types>?>(
  (ref) async {
    final client = ref.read(gqlClientProvider);

    final result = await client.query$GetTest(
      Options$Query$GetTest(fetchPolicy: FetchPolicy.networkOnly),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.parsedData?.$__schema.types;
  },
);
