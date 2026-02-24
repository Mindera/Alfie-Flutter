import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollToTop(ref, AppRoute.home.fullPath);
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          automaticallyImplyActions: false,
          automaticallyImplyLeading: false,

          backgroundColor: AppColors.neutral,
          surfaceTintColor: AppColors.transparent,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(Spacing.small),
            expandedTitleScale: 1,
            background: Image.asset('assets/images/doc_branding.png'),
            title: Search(),
          ),
        ),
        SliverList.separated(
          separatorBuilder: (context, index) =>
              SizedBox(height: Spacing.medium),
          itemBuilder: (context, index) =>
              Container(height: 100, color: AppColors.error600),
        ),
      ],
    );
  }
}
