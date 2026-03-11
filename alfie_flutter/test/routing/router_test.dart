import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Import your app code
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/src/framework.dart';

import '../../testing/fakes/route_registry_fake.dart';
import '../../testing/mocks.dart';

void main() {
  // Helper to pump the app with the specific router config
  Future<void> pumpRouterApp(
    WidgetTester tester,
    ProviderContainer container,
  ) async {
    final router = container.read(routerProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  late ProviderContainer container;
  late MockPersistentStorageService mockPersistentStorageService;
  setUp(() {
    mockPersistentStorageService = MockPersistentStorageService();

    when(
      () => mockPersistentStorageService.getBagItems(),
    ).thenReturn(<BagItem>[]);

    container = ProviderContainer(
      overrides: [
        // Inject our fake registry
        routeRegistryProvider.overrideWithValue(const FakeRouteRegistry()),
        persistentStorageServiceProvider.overrideWithValue(
          mockPersistentStorageService,
        ),
      ],
    );
  });

  group('Router Configuration -', () {
    testWidgets('Initial route is Home', (tester) async {
      addTearDown(container.dispose);

      await pumpRouterApp(tester, container);

      // Verify we are seeing the Home screen from the fake registry
      expect(find.byKey(const Key('screen:home')), findsOneWidget);
    });

    testWidgets('Can navigate to tabs (Store)', (tester) async {
      addTearDown(container.dispose);

      await pumpRouterApp(tester, container);

      // Use the GoRouter API directly to test the ROUTER logic
      final router = container.read(routerProvider);
      router.go(AppRoute.store.path);

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('screen:store')), findsOneWidget);
    });

    testWidgets('Can navigate to nested route (Store -> Product Detail)', (
      tester,
    ) async {
      addTearDown(container.dispose);

      await pumpRouterApp(tester, container);

      final router = container.read(routerProvider);

      // Navigate deep into the stack
      final deepLink =
          '${AppRoute.store.path}/${AppRoute.productDetail.path.replaceFirst(':id', '42')}';

      router.go(deepLink);
      await tester.pumpAndSettle();

      // Verify Product Detail screen is visible
      expect(find.byKey(const Key('product:42')), findsOneWidget);
    });
  });
}
