import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationHelpers on BuildContext {
  void goToProduct(String productId) {
    final state = GoRouterState.of(this);
    // Get the current base path (e.g., /store or /bag)
    final currentPath = state.uri.path;

    // Construct the relative path
    // We ensure we don't double up on slashes
    final basePath = currentPath.endsWith('/') ? currentPath : '$currentPath/';

    go(
      '$basePath${AppRoute.productDetail.path.replaceFirst(':id', productId)}',
    );
  }

  /// Navigates to an AppRoute dynamically without hardcoded paths.
  void goTo(AppRoute target, {Map<String, String> params = const {}}) {
    go(target.fullPath);
  }
}
