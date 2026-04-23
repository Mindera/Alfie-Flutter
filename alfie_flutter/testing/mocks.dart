import 'package:alfie_flutter/data/backend/auth_backend.dart';
import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/money.dart';
import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';
import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/models/size.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/data/repositories/brand_repository.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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

class MockBrand extends Mock implements Brand {}

class MockPriceRange extends Mock implements PriceRange {}

class MockProductColor extends Mock implements ProductColor {}

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

class MockMediaImage extends Mock implements MediaImage {}

class MockMedia extends Mock implements Media {}

class MockProductSize extends Mock implements ProductSize {}

class MockSizeGuide extends Mock implements SizeGuide {}

class MockVideoSource extends Mock implements VideoSource {}

class MockAuthService extends Mock implements IAuthService {}

class MockUser extends Mock implements User {}

class MockUserData extends Mock implements UserData {}

class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockBrandRepository extends Mock implements IBrandRepository {}

class MockProductRepository extends Mock implements IProductRepository {}

class MockProductListing extends Mock implements ProductListing {}

class MockUserBackend extends Mock implements IUserBackend {}

class MockBagItem extends Mock implements BagItem {}

class MockAuthBackend extends Mock implements IAuthBackend {}

class MockUserRepository extends Mock implements UserRepository {}

class MockSearchItem extends Mock implements SearchItem {}
