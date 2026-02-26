import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingViewModel extends AsyncNotifier<ProductListingState> {
  final String categoryId;
  ProductListingSort? _currentSort;

  ProductListingViewModel(this.categoryId);

  @override
  Future<ProductListingState> build() async {
    final params = ProductListingParams(
      categoryId: categoryId,
      limit: 10,
      offset: 0,
      sort: _currentSort,
    );

    final result = await ref.watch(getProductListingProvider(params).future);

    return ProductListingState(params: params, listing: result);
  }

  Future<void> updateSort(ProductListingSort sort) async {
    if (_currentSort == sort) return;

    _currentSort = sort;

    ref.invalidateSelf();

    await future;
  }

  Future<void> updateCount() async {
    ProductListing? listing = state.value?.listing;
    listing?.products.removeLast();
    state = AsyncValue.data(state.value!.copyWith(listing: listing));
    ref.invalidateSelf();

    await future;
  }
}

final productListingViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<ProductListingViewModel, ProductListingState, String>(
      ProductListingViewModel.new,
    );
