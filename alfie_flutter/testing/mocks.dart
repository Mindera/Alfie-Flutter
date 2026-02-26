import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_state.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

class MockGoRouter extends Mock implements GoRouter {}

class MockNavigationShell extends Mock implements StatefulNavigationShell {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class MockNavBarViewModel extends Mock implements NavBarViewModel {}

class MockProductListingViewModel extends AsyncNotifier<ProductListingState>
    with Mock
    implements ProductListingViewModel {}
