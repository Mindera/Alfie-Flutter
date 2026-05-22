import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Orchestrates the state and interaction logic for the primary bottom navigation bar.
final navBarViewModelProvider = Provider((ref) {
  var bagCount = 0;

  final bagItems = ref.watch(bagViewModelProvider);
  bagCount = bagItems.fold<int>(
    0,
    (combinedValue, item) => combinedValue + item.quantity,
  );

  return NavBarViewModel(ref, bagCount);
});

/// State controller managing global navigation tabs and dynamic tab decorators.
///
/// Evaluates route boundaries and integrates domain states (like [bagCount])
/// into presentation-ready formats.
class NavBarViewModel {
  final Ref _ref;

  /// The aggregate quantity of items currently residing in the user's shopping bag.
  final int bagCount;

  const NavBarViewModel(this._ref, this.bagCount);

  /// Constructs the collection of [BottomNavigationBarItem]s corresponding to the application's root tabs.
  ///
  /// Dynamically injects a [Badge] onto the bag tab when [bagCount] exceeds zero.
  List<BottomNavigationBarItem> get navBarItems {
    return AppRoute.tabs.map((tab) {
      Widget icon = Icon(tab.icon);

      if (tab == AppRoute.bag) {
        icon = Badge(
          backgroundColor: AppColors.neutral800,
          textColor: AppColors.neutral,
          label: Text('$bagCount'),
          isLabelVisible: bagCount > 0,
          child: icon,
        );
      }

      return BottomNavigationBarItem(icon: icon, label: tab.label);
    }).toList();
  }

  /// Processes tab selection intents and coordinates nested routing behaviors.
  ///
  /// Automatically detects double-taps on the active tab's root route to dispatch
  /// scroll-to-top events via the [scrollProvider].
  void handleTap(StatefulNavigationShell navigationShell, int index) {
    final isCurrentTab = index == navigationShell.currentIndex;

    if (isCurrentTab) {
      final router = _ref.read(routerProvider);
      final isAtRoot = router.state.fullPath == AppRoute.tabs[index].fullPath;

      if (isAtRoot) {
        _ref
            .read(scrollProvider(AppRoute.tabs[index].fullPath).notifier)
            .triggerReset();
      }
    }
    navigationShell.goBranch(index, initialLocation: isCurrentTab);
  }
}
