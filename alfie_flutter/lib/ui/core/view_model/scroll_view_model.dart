// lib/ui/core/view_model/scroll_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ViewModel responsible for handling scroll reset events.
/// It uses a 'tick' (int) as the state to signal the View to act.
class ScrollViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  /// Triggers a scroll reset by incrementing the state.
  void triggerReset() {
    state++;
  }
}

/// The provider for our Scroll ViewModel.
/// We use 'family' to ensure each AppRoute has its own independent state.
final scrollProvider = NotifierProvider.family<ScrollViewModel, int, String>((
  _,
) {
  return ScrollViewModel();
});
