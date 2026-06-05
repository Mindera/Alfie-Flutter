import 'dart:async';

import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/ui/core/ui/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Orchestrates the application's global navigation state and routing tree.
///
/// Integrates [GoRouter] with Riverpod to dynamically react to authentication
/// state changes via [authRepositoryProvider], ensuring route guards and
/// redirects remain synchronized with the active user session.
final routerProvider = Provider((ref) {
  final registry = ref.watch(routeRegistryProvider);
  final navigatorKey = ref.watch(navigatorKeyProvider);

  final authStateNotifier = ValueNotifier<User?>(
    ref.read(authRepositoryProvider),
  );

  ref.listen(authRepositoryProvider, (_, next) {
    authStateNotifier.value = next;
  });

  ref.onDispose(authStateNotifier.dispose);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoute.home.path,
    refreshListenable: authStateNotifier,
    redirect: (context, state) {
      final isLoggedIn = authStateNotifier.value is RegisteredUser;

      final currentRoute = AppRoute.findByPath(state.matchedLocation);
      final needsAuth = currentRoute?.needsAuth ?? false;

      if (needsAuth && !isLoggedIn) {
        return AppRoute.auth.fullPath;
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
      ..._buildRecursiveRoutes(
        [AppRoute.signIn],
        registry,
        AppRoute.signIn.name,
      ),
      ..._buildRecursiveRoutes(
        [AppRoute.createAccount],
        registry,
        AppRoute.createAccount.name,
      ),
      ..._buildRecursiveRoutes(
        [AppRoute.checkout],
        registry,
        AppRoute.checkout.name,
        redirect: (context, state) {
          final hasActiveUser = authStateNotifier.value != null;
          if (!hasActiveUser) {
            return AppRoute.identification.fullPath;
          }
          return null;
        },
      ),
      ..._buildRecursiveRoutes(
        [AppRoute.identification],
        registry,
        AppRoute.identification.name,
      ),
      ..._buildRecursiveRoutes(
        [AppRoute.orderConfirmation],
        registry,
        AppRoute.orderConfirmation.name,
      ),
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

/// Recursively constructs a nested hierarchy of [GoRoute] configurations.
///
/// Translates the statically defined [AppRoute.children] relationships into
/// actionable router branches, resolving the target UI via the injected [RouteRegistry].
List<RouteBase> _buildRecursiveRoutes(
  List<AppRoute> routes,
  RouteRegistry registry,
  String name, {
  FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
}) {
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
      redirect: redirect,
    );
  }).toList();
}
