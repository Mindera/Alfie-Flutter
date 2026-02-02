import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Import your app code
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/routing/app_route.dart';

import '../../testing/fakes/route_registry_fake.dart';

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

  group('Router Configuration -', () {
    testWidgets('Initial route is Home', (tester) async {
      final container = ProviderContainer(
        overrides: [
          // Inject our fake registry
          routeRegistryProvider.overrideWithValue(const FakeRouteRegistry()),
        ],
      );
      addTearDown(container.dispose);

      await pumpRouterApp(tester, container);

      // Verify we are seeing the Home screen from the fake registry
      expect(find.byKey(const Key('screen:home')), findsOneWidget);
    });

    testWidgets('Can navigate to tabs (Store)', (tester) async {
      final container = ProviderContainer(
        overrides: [
          routeRegistryProvider.overrideWithValue(const FakeRouteRegistry()),
        ],
      );
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
      final container = ProviderContainer(
        overrides: [
          routeRegistryProvider.overrideWithValue(const FakeRouteRegistry()),
        ],
      );
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
