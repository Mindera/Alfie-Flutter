import 'package:alfie_flutter/ui/wishlist/view/wishlist_app_bar.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_body.dart';
import 'package:flutter/material.dart';

/// The primary layout wrapper for the user's saved wishlist.
///
/// Composes the [WishlistAppBar] and [WishlistBody] into a standard [Scaffold].
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: WishlistAppBar(), body: WishlistBody());
  }
}
