import 'package:alfie_flutter/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationHelpers on BuildContext {
  String get path {
    return GoRouterState.of(this).uri.path;
  }

  /// Navigates to an AppRoute dynamically without hardcoded paths.
  void goTo(AppRoute target, {Map<String, dynamic> params = const {}}) {
    String goToPath = target.fullPath;
    for (String parameter in params.keys) {
      goToPath.replaceFirst(parameter, params[parameter]!);
    }
    go(goToPath);
  }

  /// Pushes a route onto the stack instead of replacing the current state
  void pushTo(
    AppRoute target, {
    Map<String, String> pathParams = const {},
    Map<String, String?> queryParams = const {},
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

    push(uri.toString());
  }

  void goToProduct(String productId) {
    // Get the current base path
    final currentPath = path;

    // Construct the relative path
    final basePath = currentPath.endsWith('/') ? currentPath : '$currentPath/';

    go(
      '$basePath${AppRoute.productDetail.path.replaceFirst(':id', productId)}',
    );
  }

  bool safePop() {
    if (canPop()) {
      pop();
      return true;
    }
    return false;
  }
}
