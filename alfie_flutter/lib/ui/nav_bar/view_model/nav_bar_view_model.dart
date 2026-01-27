import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navBarViewModelProvider = Provider((ref) => NavBarViewModel(ref));

class NavBarViewModel {
  NavBarViewModel(this._ref);
  final Ref _ref;

  List<BottomNavigationBarItem> get navBarItems {
    return AppRoute.tabs.map((tab) {
      return BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label);
    }).toList();
  }

  void handleTap(StatefulNavigationShell navigationShell, int index) {
    final isCurrentTab = index == navigationShell.currentIndex;
    final tabName = AppRoute.tabs[index].name;

    if (isCurrentTab) {
      final router = _ref.read(routerProvider);
      final isAtRoot = router.state.fullPath == router.namedLocation(tabName);

      if (isAtRoot) {
        _ref.read(scrollProvider(tabName).notifier).triggerReset();
      }
    }

    navigationShell.goBranch(index, initialLocation: isCurrentTab);
  }
}
