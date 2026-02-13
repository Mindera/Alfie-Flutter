import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navBarViewModelProvider = Provider((ref) => NavBarViewModel(ref));

class NavBarViewModel {
  final Ref _ref;

  NavBarViewModel(this._ref);

  List<BottomNavigationBarItem> get navBarItems {
    return AppRoute.tabs.map((tab) {
      return BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label);
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
