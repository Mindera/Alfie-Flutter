import 'dart:developer';

import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchemaTypeListView extends ConsumerWidget {
  const SchemaTypeListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get an AsyncValue object
    final schemaAsync = ref.watch(schemaTypesProvider);

    return schemaAsync.when(
      // While fetching, show a progress bar
      loading: () => const Center(child: CircularProgressIndicator()),

      // If an error occurs, show the error text
      error: (error, stack) => Center(child: Text("Error: $error")),

      // When data is ready, build your list
      data: (types) {
        if (types == null || types.isEmpty) {
          return const Center(child: Text("No types found"));
        }
        log("Fetched ${types.length} types from schema");
        return Column(
          children: [
            Text(
              "GraphQL Schema Types",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: types.length,
                itemBuilder: (context, index) {
                  final type = types[index];
                  return ListTile(
                    title: Text(type.name ?? "Unknown Type"),
                    leading: const Icon(Icons.code),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
