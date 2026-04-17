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

/// A custom HomeState to deterministically inject highlights
/// and avoid relying on the production defaults.
class TestHomeState extends HomeState {
  TestHomeState() : super(brands: const AsyncLoading());

  @override
  final List<Highlight> highlights = [
    // Triggers the branch where title != null
    Highlight(
      imageUrl: 'https://example.com/image1.jpg',
      title: 'Featured Collection',
    ),
    // Triggers the branch where title == null
    Highlight(imageUrl: 'https://example.com/image2.jpg', title: null),
  ];
}
