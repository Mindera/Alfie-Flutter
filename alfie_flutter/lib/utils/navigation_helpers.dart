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
  void pushTo(AppRoute target, {Map<String, dynamic> params = const {}}) {
    String pushPath = target.fullPath;
    for (String parameter in params.keys) {
      pushPath = pushPath.replaceFirst(
        parameter,
        params[parameter]!,
      ); // Fixed assignment
    }
    push(pushPath);
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
