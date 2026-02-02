import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  // Tabs
  home(
    path: '/home',
    isTab: true,
    icon: AppIcons.home,
    children: [productDetail],
  ),
  store(
    path: '/store',
    isTab: true,
    icon: AppIcons.menu,
    children: [productDetail],
  ),
  wishlist(
    path: '/wishlist',
    isTab: true,
    icon: AppIcons.wishlist,
    children: [productDetail],
  ),
  bag(path: '/bag', isTab: true, icon: AppIcons.bag, children: [productDetail]),
  account(
    path: '/account',
    isTab: true,
    icon: AppIcons.account,
    children: [components],
  ),
  // Sub-pages
  productDetail(path: 'product/:id'),
  components(
    path: 'components',
    children: [buttons, textField, checkboxes, radioButtons, slider],
  ),
  buttons(path: 'buttons'),
  textField(path: 'textField'),
  checkboxes(path: 'checkboxes'),
  radioButtons(path: 'radioButtons'),
  slider(path: 'slider');

  final String path;
  final bool isTab;
  final List<AppRoute> children;
  final IconData? icon;

  const AppRoute({
    required this.path,
    this.isTab = false,
    this.icon,
    this.children = const [],
  });

  static List<AppRoute> get tabs =>
      AppRoute.values.where((r) => r.isTab).toList();
  String get label => name[0].toUpperCase() + name.substring(1);
  int get tabIndex => tabs.indexOf(this);

  String get fullPath {
    if (isTab) return path;

    for (final tab in AppRoute.tabs) {
      final calculatedPath = _searchPath(tab, this);
      if (calculatedPath != null) return calculatedPath;
    }

    return path;
  }

  /// Helper to perform DFS (Depth First Search)
  String? _searchPath(AppRoute current, AppRoute target) {
    if (current == target) {
      return current.path;
    }

    for (final child in current.children) {
      final childResult = _searchPath(child, target);
      if (childResult != null) {
        final parentPath = current.path.endsWith('/')
            ? current.path
            : '${current.path}/';
        return '$parentPath$childResult';
      }
    }
    return null;
  }
}
