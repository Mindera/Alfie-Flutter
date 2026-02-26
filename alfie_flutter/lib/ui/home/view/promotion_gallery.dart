import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:flutter/material.dart';

class PromotionGallery extends StatelessWidget {
  const PromotionGallery({super.key});

  final List<Widget> promotions = const [
    PromotionBadge(
      title: "Get 50% off your first purchase!",
      description:
          "New subscribers receive 50% off their entire order. Activate message notifications and receive special discounts and updates.",
    ),
    PromotionBadge(
      title: "Get 30% off your second purchase!",
      description:
          "New subscribers receive 30% off their entire order. Activate message notifications and receive special discounts and updates.",
    ),
    PromotionBadge(
      title: "Get 99% off your third purchase!",
      description:
          "New subscribers receive 99% off their entire order. Activate message notifications and receive special discounts and updates. This is a long text. This is a long text. This is a long text. And you'll give us a lot of money. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. ",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Gallery(overlayDots: false, darkDots: true, children: promotions);
  }
}
