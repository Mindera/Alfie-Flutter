import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';

class FakeProductListingViewModel extends ProductListingViewModel {
  final ProductListingState initialState;

  FakeProductListingViewModel(this.initialState)
    : super(
        ProductListingId(
          categoryId: initialState.params.categoryId,
          query: initialState.params.query,
        ),
      );

  @override
  ProductListingState build() {
    return initialState;
  }

  @override
  void updateLayoutPreference(int preference) {
    state = state.copyWith(layoutPreference: preference);
  }
}
