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
    // needsAuth: true,
  ),
  bag(
    path: '/bag',
    isTab: true,
    icon: AppIcons.bag,
    children: [productDetail],
    // needsAuth: true,
  ),
  account(
    path: '/account',
    isTab: true,
    icon: AppIcons.account,
    children: [components, personalInformation, auth],
    needsAuth: true,
  ),
  // Sub-pages
  productDetail(path: 'product/:id'),
  search(path: 'search'),

  auth(path: 'auth'),
  signIn(path: '/signIn'),
  createAccount(path: "/createAccount"),
  personalInformation(path: 'personalInformation'),
  identification(
    path: '/identification',
    children: [contactInformation, deliveryInformation],
  ),
  checkout(
    path: '/checkout',
    children: [
      contactInformation,
      deliveryInformation,
      deliveryMethod,
      paymentMethod,
      orderConfirmation,
    ],
  ),

  contactInformation(path: 'contactInformation'),
  deliveryInformation(path: 'deliveryInformation'),
  deliveryMethod(path: 'deliveryMethod'),
  paymentMethod(path: 'paymentMethod'),
  orderConfirmation(path: 'orderConfirmation'),

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
  final bool needsAuth;

  const AppRoute({
    required this.path,
    this.isTab = false,
    this.icon,
    this.children = const [],
    this.needsAuth = false,
  });

  static List<AppRoute> get tabs =>
      AppRoute.values.where((r) => r.isTab).toList();

  static List<AppRoute> get rootRoutes =>
      AppRoute.values.where((r) => r.path.startsWith('/')).toList();

  String get label => name.capitalize();

  /// Gets the full path of a given route
  ///
  /// When a route can be instantiated over more than one base route, it returns the first match
  String get fullPath {
    if (path.startsWith('/')) return path;

    // Search starting from all root routes, not just tabs
    for (final root in AppRoute.rootRoutes) {
      final calculatedPath = _searchPath(root, this);
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

  /// Finds an AppRoute by its path string
  static AppRoute? findByPath(String path) {
    return AppRoute.values.where((route) => route.path == path).firstOrNull;
  }
}
