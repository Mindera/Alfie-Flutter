import 'package:alfie_flutter/data/models/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The ViewModel logic
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() => HomeState();

  void updateText(String newText) {
    state = HomeState(displayedText: newText);
  }
}

// The Provider that the View will listen to
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
