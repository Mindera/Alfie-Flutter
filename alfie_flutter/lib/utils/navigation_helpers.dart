import 'package:alfie_flutter/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Provides semantic routing shorthands on the [BuildContext] to simplify GoRouter navigation.
extension NavigationHelpers on BuildContext {
  /// Resolves the current active URI path from the router state.
  String get path {
    return GoRouterState.of(this).uri.path;
  }

  /// Replaces the current navigation state with a dynamic [target] route.
  ///
  /// Iterates through [params] to dynamically inject URL segments before executing the route.
  void goTo(
    AppRoute target, {
    Map<String, dynamic> params = const {},
    Object? extra,
  }) {
    String goToPath = target.fullPath;
    for (String parameter in params.keys) {
      goToPath = goToPath.replaceFirst(
        parameter,
        params[parameter]!.toString(),
      );
    }
    go(goToPath, extra: extra);
  }

  /// Pushes a [target] route onto the navigation stack, preserving the current state beneath it.
  ///
  /// Safely encodes [pathParams] to prevent malformed URIs and appends optional [queryParams].
  void pushTo(
    AppRoute target, {
    Map<String, String> pathParams = const {},
    Map<String, String?> queryParams = const {},
    Object? extra,
  }) {
    String path = target.fullPath;

    // Replace path parameters like :id
    pathParams.forEach((key, value) {
      path = path.replaceFirst(':$key', Uri.encodeComponent(value));
    });

    final uri = Uri(
      path: path,
      queryParameters: queryParams.isEmpty
          ? null
          : queryParams.map((k, v) => MapEntry(k, v ?? '')),
    );

    push(uri.toString(), extra: extra);
  }

  /// Appends the product detail route to the current active [path] for nested catalog navigation.
  void goToProduct(String productId) {
    // Get the current base path
    final currentPath = path;

    // Construct the relative path
    final basePath = currentPath.endsWith('/') ? currentPath : '$currentPath/';

    go(
      '$basePath${AppRoute.productDetail.path.replaceFirst(':id', productId)}',
    );
  }

  /// Attempts to pop the current route, falling back to [AppRoute.home] if the stack is empty.
  bool safePop() {
    if (canPop()) {
      pop();
      return true;
    }
    goTo(AppRoute.home);
    return false;
  }
}
