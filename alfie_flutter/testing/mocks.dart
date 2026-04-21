import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

class MockGoRouter extends Mock implements GoRouter {}

class MockNavigationShell extends Mock implements StatefulNavigationShell {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class MockBuildContext extends Mock implements BuildContext {}

class MockNavBarViewModel extends Mock implements NavBarViewModel {}

class MockPersistentStorageService extends Mock
    implements IPersistentStorageService {}

class MockProduct extends Mock implements Product {}

class MockWishlistRepository extends Mock implements WishlistRepository {}

class MockProductDetailViewModel extends Mock
    implements ProductDetailViewModel {}

class MockProductVariant extends Mock implements ProductVariant {}

class MockPrice extends Mock implements Price {}

class MockMoney extends Mock implements Money {}

class MockBinaryReader extends Mock implements BinaryReader {}

class MockBinaryWriter extends Mock implements BinaryWriter {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockBagRepository extends Mock implements BagRepository {}

class MockCheckoutState extends Mock implements CheckoutState {}
