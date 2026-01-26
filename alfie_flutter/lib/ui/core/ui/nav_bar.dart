import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavBar extends ConsumerWidget {
  const NavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // Modular items based on the tabs defined in AppRoute
      items: AppRoute.tabs
          .map(
            (tab) =>
                BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label),
          )
          .toList(),
      currentIndex: navigationShell.currentIndex,
      onTap: (int index) => _onTap(ref, index),
    );
  }

  void _onTap(WidgetRef ref, int index) {
    // Using the goBranch method makes sure the last navigation state of the
    // Navigator for the branch is restored.
    final isCurrentTab = index == navigationShell.currentIndex;

    if (isCurrentTab) {
      ref
          .read(scrollProvider(AppRoute.tabs[index].name).notifier)
          .triggerReset();
    }

    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: isCurrentTab,
    );
  }
}
