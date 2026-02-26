import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:alfie_flutter/ui/home/view_model/highlight.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeState {
  final List<Highlight> highlights = [
    Highlight(
      imageUrl:
          'https://images.pexels.com/photos/6769357/pexels-photo-6769357.jpeg',
      title: "Transcending Trends for Breezy Nights",
    ),
    Highlight(
      imageUrl:
          'https://images.pexels.com/photos/1381553/pexels-photo-1381553.jpeg',
    ),
    Highlight(
      imageUrl:
          'https://images.pexels.com/photos/10679191/pexels-photo-10679191.jpeg',
    ),
    Highlight(
      imageUrl:
          'https://images.pexels.com/photos/10037708/pexels-photo-10037708.jpeg',
    ),
    Highlight(
      imageUrl:
          'https://images.pexels.com/photos/247908/pexels-photo-247908.jpeg',
    ),
  ];

  final List<String> categories = const [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
  ];

  final List<PromotionBadge> promotions = const [
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

  final AsyncValue<List<Brand>> brands;

  HomeState({required this.brands});
}
