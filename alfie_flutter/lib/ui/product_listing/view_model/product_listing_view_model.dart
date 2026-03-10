import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingViewModel extends Notifier<ProductListingState> {
  final ProductListingId listingId;
  ProductListingSort? _currentSort;

  ProductListingViewModel(this.listingId);

  @override
  ProductListingState build() {
    final params = ProductListingParams(
      categoryId: listingId.categoryId,
      query: listingId.query,
      limit: 10,
      offset: 0,
      sort: _currentSort,
    );

    final resultAsync = ref.watch(getProductListingProvider(params));

    return ProductListingState(
      params: params,
      listing: resultAsync,
      layoutPreference: ref
          .watch(persistentStorageServiceProvider)
          .getPlpLayoutPreference(),
    );
  }

  void updateCount() {
    ProductListing? listing = state.listing.value;
    listing?.products.removeLast();
    state = state.copyWith(listing: AsyncValue.loading());

    ref.invalidateSelf();
  }

  void updateLayoutPreference(int columns) async {
    await ref
        .read(persistentStorageServiceProvider)
        .savePlpLayoutPreference(columns);

    state = state.copyWith(layoutPreference: columns);
  }
}

final productListingViewModelProvider = NotifierProvider.autoDispose
    .family<ProductListingViewModel, ProductListingState, ProductListingId>(
      ProductListingViewModel.new,
    );
