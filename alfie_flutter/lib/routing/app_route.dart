import 'package:flutter/material.dart';

enum AppRoute {
  // Tabs
  home(path: '/home', isTab: true, icon: Icons.home, children: [productDetail]),
  store(
    path: '/store',
    isTab: true,
    icon: Icons.store,
    children: [productDetail],
  ),
  wishlist(
    path: '/wishlist',
    isTab: true,
    icon: Icons.favorite,
    children: [productDetail],
  ),
  bag(
    path: '/bag',
    isTab: true,
    icon: Icons.shopping_bag,
    children: [productDetail],
  ),
  account(path: '/account', isTab: true, icon: Icons.person),
  // Sub-pages
  productDetail(path: 'product/:id');

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
  static String getFullPath(AppRoute route, [String parentPath = '']) {
    final fullPath = parentPath + route.path;
    return fullPath;
  }
}
