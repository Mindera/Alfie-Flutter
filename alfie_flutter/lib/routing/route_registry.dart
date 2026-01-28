import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/ui/account/view/account_screen.dart';
import 'package:alfie_flutter/ui/bag/view/bag_screen.dart';
import 'package:alfie_flutter/ui/home/view/home_screen.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_detail_screen.dart';
import 'package:alfie_flutter/ui/store/view/store_screen.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Injectable contract for resolving routes to screens.
abstract class RouteRegistry {
  Widget getScreen(AppRoute route, GoRouterState state);
}

/// Default implementation used in production.
class DefaultRouteRegistry implements RouteRegistry {
  const DefaultRouteRegistry();

  @override
  Widget getScreen(AppRoute route, GoRouterState state) {
    return switch (route) {
      AppRoute.home => const HomeScreen(),
      AppRoute.store => const StoreScreen(),
      AppRoute.wishlist => const WishlistScreen(),
      AppRoute.bag => const BagScreen(),
      AppRoute.account => const AccountScreen(),
      AppRoute.productDetail => ProductDetailScreen(
        id: state.pathParameters['id'] ?? '',
      ),
    };
  }
}

final routeRegistryProvider = Provider<RouteRegistry>(
  (ref) => const DefaultRouteRegistry(),
);
