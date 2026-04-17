import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

/// A Fake ViewModel to inject specific UI states for testing.
class FakeHomeViewModel extends HomeViewModel {
  final HomeState _state;

  FakeHomeViewModel(this._state);

  @override
  HomeState build() {
    return _state;
  }
}
