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
      // Here, the items of BottomNavigationBar are hard coded. In a real
      // world scenario, the items would most likely be generated from the
      // branches of the shell route, which can be fetched using
      // `navigationShell.route.branches`.
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section D'),
        BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section E'),
      ],
      currentIndex: navigationShell.currentIndex,
      // Navigate to the current location of the branch at the provided index
      // when tapping an item in the BottomNavigationBar.
      onTap: (int index) => navigationShell.goBranch(index),
    );
  }
}
