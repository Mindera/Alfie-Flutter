enum AppRoute {
  // Tabs
  home(path: '/home', isTab: true),
  store(path: '/store', isTab: true, children: [productDetail]),
  wishlist(path: '/wishlist', isTab: true),
  bag(path: '/bag', isTab: true),
  account(path: '/account', isTab: true),
  // Sub-pages
  productDetail(path: 'product/:id');

  final String path;
  final bool isTab;
  final List<AppRoute> children;

  const AppRoute({
    required this.path,
    this.isTab = false,
    this.children = const [],
  });

  static List<AppRoute> get tabs =>
      AppRoute.values.where((r) => r.isTab).toList();
}
