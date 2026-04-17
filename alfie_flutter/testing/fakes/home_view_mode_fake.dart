import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:alfie_flutter/ui/home/view_model/highlight.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Fake ViewModel to inject specific UI states for testing.
class FakeHomeViewModel extends HomeViewModel {
  final HomeState _state;

  FakeHomeViewModel(this._state);

  @override
  HomeState build() {
    return _state;
  }
}

/// A custom HomeState to deterministically inject state
/// and avoid relying on the production defaults or infinite loaders.
class TestHomeState extends HomeState {
  TestHomeState({
    this.highlights = const [
      Highlight(
        imageUrl: 'https://example.com/image1.jpg',
        title: 'Featured Collection',
      ),
      Highlight(imageUrl: 'https://example.com/image2.jpg', title: null),
    ],
    this.promotions = const [
      PromotionBadge(
        title: "Exclusive Offer: 20% Off!",
        description:
            "Unlock 20% off your next purchase. Subscribe to our newsletter for more exclusive deals and updates.",
      ),
    ],
    // Default to an empty data state so we don't trigger infinite loading spinners
    super.brands = const AsyncData([]),
  });

  @override
  // ignore: overridden_fields
  final List<Highlight> highlights;

  @override
  // ignore: overridden_fields
  final List<PromotionBadge> promotions;
}
