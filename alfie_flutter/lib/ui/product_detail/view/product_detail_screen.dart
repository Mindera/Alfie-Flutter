import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_main_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(getProductProvider(id));
    // final asyncProduct = ref.watch(getProductProviderTest);
    return asyncProduct.when(
      data: (product) => product == null
          ? Center(child: Text("Not Found"))
          : ProductDetail(product),
      loading: () => Center(),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: Icon(AppIcons.back),
            onPressed: () => context.pop(),
          ),
          expandedHeight: MediaQuery.of(context).size.width * 1.25,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeInImage.assetNetwork(
              placeholder: "assets/images/fallback_image.png",
              image: product.colours!.first.media!.first.when(
                image: (MediaImage image) => image.url,
                video: (MediaVideo video) => video.sources.first.url,
                orElse: () => '',
              ),
              fit: BoxFit.cover,
              placeholderFit: BoxFit.cover,

              fadeInDuration: const Duration(milliseconds: 300),

              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/fallback_image.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(Spacing.small),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                spacing: Spacing.medium,
                children: [ProductMainInfo(product: product)],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
