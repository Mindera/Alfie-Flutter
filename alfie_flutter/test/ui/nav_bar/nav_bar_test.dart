import 'package:alfie_flutter/routing/router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';

import '../../../testing/models/test_route_registry.dart';

void main() {
  testWidgets('navigates to selected tab when tapped', (tester) async {
    final container = ProviderContainer(
      overrides: [
        routeRegistryProvider.overrideWithValue(const TestRouteRegistry()),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Choose the store tab for the assertion
    final tab = AppRoute.store;

    // Initial screen should be home
    expect(find.byKey(Key('screen:${AppRoute.home.name}')), findsOneWidget);

    final storeIcon = find.byIcon(tab.icon!);
    expect(storeIcon, findsOneWidget);
    await tester.tap(storeIcon);
    await tester.pumpAndSettle();

    // We should be on the store screen now
    expect(find.byKey(Key('screen:${tab.name}')), findsOneWidget);
  });

  testWidgets('tapping current tab while in sub-route returns to branch root', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        routeRegistryProvider.overrideWithValue(const TestRouteRegistry()),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final tab = AppRoute.store;
    final storeIcon = find.byIcon(tab.icon!);
    expect(storeIcon, findsOneWidget);

    // Deep-link to a child route inside the store branch (product detail)
    router.go(
      '${tab.path}/${AppRoute.productDetail.path.replaceAll(':id', '123')}',
    );
    await tester.pumpAndSettle();

    // Verify we're on the product page
    expect(find.byKey(Key('product:123')), findsOneWidget);

    // Tap the store tab (current tab) - should return to branch root
    await tester.tap(storeIcon);
    await tester.pumpAndSettle();

    // Now we should be at the root of the store branch
    expect(find.byKey(Key('screen:${tab.name}')), findsOneWidget);
  });

  testWidgets('tapping current tab at root triggers scroll reset', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        routeRegistryProvider.overrideWithValue(const TestRouteRegistry()),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final tab = AppRoute.store;
    final tabName = tab.name;
    final storeIcon = find.byIcon(tab.icon!);
    expect(storeIcon, findsOneWidget);

    // Navigate to the tab root first
    await tester.tap(storeIcon);
    await tester.pumpAndSettle();
    expect(find.byKey(Key('screen:${tab.name}')), findsOneWidget);

    // Read scroll provider initial state
    final initial = container.read(scrollProvider(tabName));

    // Tap the same tab again to trigger reset
    await tester.tap(storeIcon);
    await tester.pumpAndSettle();

    final after = container.read(scrollProvider(tabName));
    expect(after, initial + 1);
  });
}
