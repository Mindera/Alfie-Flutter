import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/data/models/app_route.dart';

/// Shared test helper: lightweight RouteRegistry that returns simple pages
/// identifiable by Keys so widget tests can assert navigation without real UI.
class FakeRouteRegistry implements RouteRegistry {
  const FakeRouteRegistry();

  @override
  Widget getScreen(AppRoute route, GoRouterState state) {
    if (route == AppRoute.productDetail) {
      final id = state.pathParameters['id'] ?? '';
      return Scaffold(
        body: Center(child: Text('product:$id', key: Key('product:$id'))),
      );
    }
    return Scaffold(
      body: Center(child: Text(route.name, key: Key('screen:${route.name}'))),
    );
  }
}
