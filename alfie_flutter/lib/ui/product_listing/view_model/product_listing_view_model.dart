import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_id.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Orchestrates the presentation state for a specific product listing configuration.
///
/// Isolated by [ProductListingId] to ensure independent caching and scroll states
/// across different categories or search queries.
final productListingViewModelProvider = NotifierProvider.autoDispose
    .family<ProductListingViewModel, ProductListingState, ProductListingId>(
      ProductListingViewModel.new,
    );

/// State controller managing the aggregate [ProductListingState].
///
/// Coordinates network fetching via [getProductListingProvider] and synchronizes
/// user display preferences with local storage.
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

  /// Mutates the active listing by dropping the last product and forcing a provider rebuild.
  void updateCount() {
    final ProductListing? listing = state.listing.value;
    listing?.products.removeLast();
    state = state.copyWith(listing: const AsyncValue.loading());

    ref.invalidateSelf();
  }

  /// Updates the PLP grid layout to the specified number of [columns] and persists the preference.
  void updateLayoutPreference(int columns) async {
    await ref
        .read(persistentStorageServiceProvider)
        .savePlpLayoutPreference(columns);

    state = state.copyWith(layoutPreference: columns);
  }
}
