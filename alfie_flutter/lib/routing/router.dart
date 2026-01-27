import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/ui/core/ui/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final routerProvider = Provider((ref) {
  final registry = ref.watch(routeRegistryProvider);
  // GoRouter configuration
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.home.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) => ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: AppRoute.tabs.map((tab) {
          return StatefulShellBranch(
            routes: [
              GoRoute(
                name: tab.name,
                path: tab.path,
                builder: (context, state) => registry.getScreen(tab, state),
                routes: tab.children
                    .map(
                      (child) => GoRoute(
                        name: '${tab.name}_${child.name}',
                        path: child.path,
                        builder: (context, state) =>
                            registry.getScreen(child, state),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
});
