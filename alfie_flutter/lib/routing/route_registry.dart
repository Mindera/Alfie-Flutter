import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/account/view/account_screen.dart';
import 'package:alfie_flutter/ui/auth/view/auth_screen.dart';
import 'package:alfie_flutter/ui/auth/view/create_account_screen.dart';
import 'package:alfie_flutter/ui/bag/view/bag_screen.dart';
import 'package:alfie_flutter/ui/checkout/view/checkout_screen.dart';
import 'package:alfie_flutter/ui/checkout/view/identification_screen.dart';
import 'package:alfie_flutter/ui/core/ui/button/buttons_screen.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkboxes_screen.dart';
import 'package:alfie_flutter/ui/core/ui/components_screen.dart';
import 'package:alfie_flutter/ui/core/ui/radio_button/radio_buttons_screen.dart';
import 'package:alfie_flutter/ui/core/ui/slider/slider_screen.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/text_field_screen.dart';
import 'package:alfie_flutter/ui/home/view/home_screen.dart';
import 'package:alfie_flutter/ui/auth/view/sign_in_screen.dart';
import 'package:alfie_flutter/ui/personal_information/view/personal_information_screen.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_detail_screen.dart';
import 'package:alfie_flutter/ui/search/view/search_screen.dart';
import 'package:alfie_flutter/ui/store/view/store_screen.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Injectable contract for resolving routes to screens.
abstract class RouteRegistry {
  Widget getScreen(AppRoute route, GoRouterState state);
}

/// Default implementation used in production.
class DefaultRouteRegistry implements RouteRegistry {
  const DefaultRouteRegistry();

  @override
  Widget getScreen(AppRoute route, GoRouterState state) {
    return switch (route) {
      AppRoute.home => const HomeScreen(),
      AppRoute.store => const StoreScreen(),
      AppRoute.wishlist => const WishlistScreen(),
      AppRoute.bag => const BagScreen(),
      AppRoute.account => const AccountScreen(),
      AppRoute.productDetail => ProductDetailScreen(
        id: state.pathParameters['id'] ?? '',
      ),
      AppRoute.components => ComponentsScreen(),
      AppRoute.buttons => ButtonsScreen(),
      AppRoute.textField => TextFieldScreen(),
      AppRoute.checkboxes => CheckboxesScreen(),
      AppRoute.radioButtons => RadioButtonsScreen(),
      AppRoute.slider => SliderScreen(),
      AppRoute.search => SearchScreen(),
      AppRoute.signIn => SignInScreen(),
      AppRoute.personalInformation => PersonalInformationScreen(),
      AppRoute.auth => AuthScreen(),
      AppRoute.createAccount => CreateAccountScreen(),
      AppRoute.checkout => CheckoutScreen(),
      AppRoute.identification => IdentificationScreen(),
    };
  }
}

final routeRegistryProvider = Provider<RouteRegistry>(
  (ref) => const DefaultRouteRegistry(),
);
