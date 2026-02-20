import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_screen.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreScreen extends HookConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollToTop(ref, AppRoute.store.fullPath);
    return ProductListingScreen(categoryId: '', controller: controller);
  }
}
