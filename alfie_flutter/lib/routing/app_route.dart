import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  // Tabs
  home(
    path: '/home',
    isTab: true,
    icon: AppIcons.home,
    children: [productDetail, search],
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
  search(path: 'search'),
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

  String get label => name.capitalize();

  /// Gets the full path of a given route
  ///
  /// When a route can be instantiated over more than one base route, it returns the first match
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
