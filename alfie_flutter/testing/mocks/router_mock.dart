import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';

/// This builds a real `GoRouter` and intentionally exercises the
/// `NavigationHelpers` extension. It's a lightweight shared test utility.
GoRouter buildMockRouter({
  required AppRoute baseRoute,
  required String initialLocation,
  required String productId,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: baseRoute.path,
        builder: (context, state) => Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => context.goToProduct(productId),
                child: const Text('go'),
              );
            },
          ),
        ),
        routes: [
          GoRoute(
            path: AppRoute.productDetail.path,
            builder: (context, state) => Text(state.uri.path),
          ),
        ],
      ),
    ],
  );
}
