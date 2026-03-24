import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
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

  final authStateNotifier = ValueNotifier<bool>(
    ref.read(authRepositoryProvider) != null,
  );

  ref.listen(authRepositoryProvider, (_, next) {
    authStateNotifier.value = next != null;
  });

  ref.onDispose(authStateNotifier.dispose);

  // GoRouter configuration
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.home.path,

    refreshListenable: authStateNotifier,

    // router.dart inside the GoRouter configuration
    redirect: (context, state) {
      final isLoggedIn = authStateNotifier.value;
      final isGoingToLogin = state.matchedLocation == AppRoute.login.path;

      final currentRoute = AppRoute.findByPath(state.matchedLocation);
      final needsAuth = currentRoute?.needsAuth ?? false;

      if (needsAuth && !isLoggedIn) {
        return AppRoute.login.path;
      }

      if (isLoggedIn && isGoingToLogin) {
        return AppRoute.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        redirect: (context, state) {
          return AppRoute.home.path;
        },
      ),
      ..._buildRecursiveRoutes([AppRoute.login], registry, AppRoute.login.name),
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
                routes: _buildRecursiveRoutes(tab.children, registry, tab.name),
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
});

List<RouteBase> _buildRecursiveRoutes(
  List<AppRoute> routes,
  RouteRegistry registry,
  String name,
) {
  if (routes.isEmpty) {
    return [];
  }
  return routes.map((route) {
    return GoRoute(
      path: route.path,
      builder: (context, state) => registry.getScreen(route, state),
      routes: _buildRecursiveRoutes(
        route.children,
        registry,
        "$name-${route.name}",
      ),
    );
  }).toList();
}
