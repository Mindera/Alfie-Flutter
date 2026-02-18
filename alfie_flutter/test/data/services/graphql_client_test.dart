import 'dart:io';

import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:graphql/client.dart';

void main() {
  setUp(() async {
    final tempDir = Directory.systemTemp.createTempSync();

    HiveStore.init(onPath: tempDir.path);

    await HiveStore.openBox(HiveStore.defaultBoxName);

    await Environment.load();
  });

  test(
    'gqlClientProvider initializes all dependencies and returns a client',
    () {
      final container = ProviderContainer();

      addTearDown(container.dispose);

      final client = container.read(gqlClientProvider);

      expect(client, isA<GraphQLClient>());

      expect(client.link, isA<HttpLink>());

      expect(client.cache.store, isA<HiveStore>());

      final httpLink = client.link as HttpLink;
      expect(httpLink.uri.toString(), Environment.instance.graphqlServerUrl);
    },
  );
}
