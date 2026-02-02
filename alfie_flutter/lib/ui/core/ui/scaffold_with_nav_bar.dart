import 'package:alfie_flutter/ui/nav_bar/view/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Root layout wrapper that provides a Scaffold with bottom navigation bar.
///
/// [ScaffoldWithNavBar] serves as the shell for go_router's
/// [StatefulShellRoute], managing the main app layout with:
/// - Safe area insets handling for the navigation content
/// - Persistent bottom navigation bar for tab-based navigation
/// - Multiple independent navigation stacks
///
/// See also:
/// - [StatefulNavigationShell] from go_router for navigation management
/// - [NavBar] which renders the bottom navigation UI
class ScaffoldWithNavBar extends ConsumerWidget {
  /// The navigation shell managing multiple independent navigation stacks.
  ///
  /// Provided by go_router's [StatefulShellRoute] and handles transitions
  /// between different navigation branches (tabs) while preserving each
  /// branch's navigation history.
  final StatefulNavigationShell navigationShell;

  /// Constructs a [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavBar(navigationShell: navigationShell),
    );
  }
}
