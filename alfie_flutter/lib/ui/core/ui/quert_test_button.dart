import 'dart:developer';

import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/data/services/queries/test.graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryTestButton extends ConsumerWidget {
  const QueryTestButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final client = ref.read(gqlClientProvider);

        final QueryResult<Query$GetTest> result = await client.query$GetTest(
          Options$Query$GetTest(fetchPolicy: FetchPolicy.networkOnly),
        );

        final schemaTypes = result.parsedData?.$__schema.types;

        log("Found ${schemaTypes?.length} types in schema.");

        if (schemaTypes != null) {
          for (var type in schemaTypes) {
            log("Type Name: ${type.name}");
          }
        }
      },
      child: const Text('Run Test Query'),
    );
  }
}
