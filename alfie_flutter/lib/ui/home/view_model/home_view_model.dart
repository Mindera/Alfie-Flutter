import 'package:alfie_flutter/data/repositories/brand_repository.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates data fetching and presentation state for the Home screen.
final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);

/// State controller managing the aggregate [HomeState].
///
/// Currently proxies the remote [brandListProvider] while holding
/// static mock data for highlights and promotions.
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    final brandsAsync = ref.watch(brandListProvider);
    return HomeState(brands: brandsAsync);
  }
}
