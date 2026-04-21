import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navBarViewModelProvider = Provider((ref) {
  var bagCount = 0;

  final bagItems = ref.watch(bagViewModelProvider);
  bagCount = bagItems.fold<int>(
    0,
    (combinedValue, item) => combinedValue + item.quantity,
  );

  return NavBarViewModel(ref, bagCount);
});

class NavBarViewModel {
  final Ref _ref;
  final int bagCount;

  NavBarViewModel(this._ref, this.bagCount);

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
