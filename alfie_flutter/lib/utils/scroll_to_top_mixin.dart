import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ScrollToTopMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  // This controller is created once and persists because of the State
  late final ScrollController scrollController;

  /// The route associated with this screen
  AppRoute get route;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    ref.listenManual(scrollProvider(route.name), (prev, next) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
