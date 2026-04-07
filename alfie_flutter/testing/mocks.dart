import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
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

class MockPersistentStorageService extends Mock
    implements IPersistentStorageService {}

class MockProduct extends Mock implements Product {}

class MockWishlistRepository extends Mock implements WishlistRepository {}

class MockProductDetailViewModel extends Mock
    implements ProductDetailViewModel {}
