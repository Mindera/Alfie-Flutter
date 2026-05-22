import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:alfie_flutter/ui/home/view_model/highlight.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Represents the complete presentation state for the Home screen.
///
/// Aggregates promotional banners, featured [Highlight] content, and
/// an asynchronous feed of [Brand] entities into a single UI-consumable object.
class HomeState {
  /// A static collection of featured imagery for the top gallery carousel.
  final List<Highlight> highlights = const [
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

  /// Static product category filters for the horizontal navigation carousel.
  final List<String> categories = const [
    "Category A",
    "Category B",
    "Category C",
    "Category D",
    "Category E",
    "Category F",
    "Category G",
    "Category H",
    "Category I",
  ];

  /// Static promotional banners presented in the promotion gallery.
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

  /// Asynchronous feed of available brands fetched from the remote API.
  final AsyncValue<List<Brand>> brands;

  const HomeState({required this.brands});
}
