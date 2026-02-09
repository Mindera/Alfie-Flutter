import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(AppIcons.back, size: 24),
          expandedHeight: MediaQuery.of(context).size.width * 1.25,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/fallback_image.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(),
        SliverPadding(
          padding: const EdgeInsets.all(Spacing.small),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                color: Colors.green,
                height: 100,
                margin: const EdgeInsets.only(bottom: Spacing.small),
              );
            }),
          ),
        ),
      ],
    );
  }
}
