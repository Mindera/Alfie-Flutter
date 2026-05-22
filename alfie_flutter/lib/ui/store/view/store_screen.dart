import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/product_listing/view/product_listing_screen.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The root destination for the "Store" navigation tab.
///
/// Acts as an unfiltered global catalog view by rendering a [ProductListingScreen]
/// with an empty [ProductListingId]. Integrates the [useScrollToTop] hook to
/// intercept and handle tab-driven scroll reset events.
class StoreScreen extends HookConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollToTop(ref, AppRoute.store.fullPath);
    return ProductListingScreen(
      id: const ProductListingId(),
      controller: controller,
    );
  }
}
