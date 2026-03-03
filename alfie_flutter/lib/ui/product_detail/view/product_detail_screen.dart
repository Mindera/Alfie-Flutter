import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_main_info.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.id, super.key});

  final String id;
  static const double _galleryAspectRatio = 2 / 3; // 2 : 3

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailViewModelProvider(id));

    ProductDetailViewModel getViewModel() =>
        ref.read(productDetailViewModelProvider(id).notifier);

    return Container(
      color: AppColors.neutral,
      child: state.product.when(
        loading: () => Center(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (product) {
          if (product == null) {
            return const Center(child: Text("Not Found"));
          }
          return CustomScrollView(
            slivers: [
              // 1. Header Sliver
              SliverAppBar(
                primary: true,

                automaticallyImplyActions: false,
                automaticallyImplyLeading: false,

                flexibleSpace: FlexibleSpaceBar(
                  background: Header(
                    title: product.name.capitalizeAll(),
                    leading: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(AppIcons.back),
                      onPressed: () => context.safePop(),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => getViewModel().shareProduct(),
                        icon: Icon(AppIcons.share),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Gallery Sliver
              SliverAppBar(
                primary: false,

                automaticallyImplyActions: false,
                automaticallyImplyLeading: false,

                expandedHeight:
                    context.mediaQuery.size.width / _galleryAspectRatio,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Gallery(
                    aspectRatio: _galleryAspectRatio,
                    children:
                        product.colours
                            ?.expand((color) => color.media ?? <Media>[])
                            .map((media) {
                              final mediaUrl = media.firstUrl;

                              return ImageFactory.network(mediaUrl);
                            })
                            .toList() ??
                        [],
                  ),
                ),
              ),

              // 3. Product Content Sliver
              SliverPadding(
                padding: const EdgeInsets.all(Spacing.small),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Spacing.medium,
                      children: [
                        ProductMainInfo(product: product),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: Spacing.small,
                          children: [
                            Text(
                              product.longDescription ??
                                  product.shortDescription,
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              "Color Name | Ref. 0273/393",
                              style: context.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
