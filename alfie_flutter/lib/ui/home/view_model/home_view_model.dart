import 'package:alfie_flutter/data/repositories/brand_repository.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    final brandsAsync = ref.watch(brandListProvider);
    return HomeState(brands: brandsAsync);
  }
}

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);
