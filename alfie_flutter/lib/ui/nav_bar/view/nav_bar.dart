import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A persistent bottom navigation rail governing top-level view transitions.
///
/// Synchronizes the [StatefulNavigationShell] from GoRouter with the visual
/// state evaluated by [navBarViewModelProvider].
class NavBar extends ConsumerWidget {
  /// The shell managing the state of the nested routing branches.
  final StatefulNavigationShell navigationShell;

  const NavBar({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(navBarViewModelProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: viewModel.navBarItems,
      currentIndex: navigationShell.currentIndex,
      onTap: (index) => viewModel.handleTap(navigationShell, index),
    );
  }
}
