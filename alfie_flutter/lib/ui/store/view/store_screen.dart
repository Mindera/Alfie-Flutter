import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/scroll_to_top_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Your screen remains lean and "Stateless-like" in appearance
class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

// All the boilerplate logic is hidden in the Mixin
class _StoreScreenState extends ConsumerState<StoreScreen>
    with ScrollToTopMixin {
  @override
  AppRoute get route => AppRoute.store;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 101,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Store Item $index'),
          onTap: () {
            context.goToProduct('$index');
          },
        );
      },
    );
  }
}
