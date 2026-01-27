import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// nav_bar.dart

class NavBar extends ConsumerWidget {
  const NavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(navBarViewModelProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // The View now just consumes pre-formatted items
      items: viewModel.navBarItems,
      currentIndex: navigationShell.currentIndex,
      onTap: (index) => viewModel.handleTap(navigationShell, index),
    );
  }
}
