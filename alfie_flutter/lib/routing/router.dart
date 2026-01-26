import 'package:alfie_flutter/ui/account/view/account_screen.dart';
import 'package:alfie_flutter/ui/bag/view/bag_screen.dart';
import 'package:alfie_flutter/ui/core/ui/scaffold_with_nav_bar.dart';
import 'package:alfie_flutter/ui/home/view/home_screen.dart';
import 'package:alfie_flutter/ui/store/view/store_screen.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
// final GlobalKey<NavigatorState> _sectionANavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider((ref) {
  // GoRouter configuration
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              // Return the widget that implements the custom shell (in this case
              // using a BottomNavigationBar). The StatefulNavigationShell is passed
              // to be able access the state of the shell and to navigate to other
              // branches in a stateful way.
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            // navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/home',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(),
                routes: <RouteBase>[
                  // Can add sub-routes here which will be shown
                  // in the branch navigator.
                  // Example:
                  // GoRoute(
                  //   path: 'details',
                  //   builder: (BuildContext context, GoRouterState state) =>
                  //       const DetailsScreen(label: 'A'),
                  // ),
                ],
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the second tab of the
                // bottom navigation bar.
                path: '/store',
                builder: (BuildContext context, GoRouterState state) =>
                    const StoreScreen(),
              ),
            ],
          ),

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the third tab of the
                // bottom navigation bar.
                path: '/wishlist',
                builder: (BuildContext context, GoRouterState state) =>
                    const WishlistScreen(),
              ),
            ],
          ),
          // The route branch for the fourth tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the fourth tab of the
                // bottom navigation bar.
                path: '/bag',
                builder: (BuildContext context, GoRouterState state) =>
                    const BagScreen(),
              ),
            ],
          ),
          // The route branch for the fifth tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the fifth tab of the
                // bottom navigation bar.
                path: '/account',
                builder: (BuildContext context, GoRouterState state) =>
                    const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
