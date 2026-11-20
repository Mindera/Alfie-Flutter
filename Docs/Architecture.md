# Alfie Flutter — Architecture

## Architecture & Code Organization

### Clean Architecture Layers

The project follows Clean Architecture with three distinct layers:

**Data Layer** (`lib/data/`)
- Repository implementations (GraphQL-backed)
- GraphQL mappers (extension methods)
- Local storage (Hive adapters)
- Network clients and interceptors

**Domain Layer** (embedded within features and `lib/models/`)
- Domain models (immutable data classes)
- Repository interfaces (abstract classes)
- Business logic that is UI-independent

**Presentation Layer** (`lib/ui/`)
- Screens and widgets (`view/`)
- ViewModels as Riverpod Notifiers (`view_model/`)
- Immutable state classes

### MVVM with Riverpod Notifier Pattern

Each feature follows the MVVM pattern using Riverpod's `Notifier` class:

```
View (Screen) ──watches──▶ ViewModel (Notifier<State>)
                                    │
                                    ▼
                            Repository (Interface)
                                    │
                                    ▼
                          Repository Impl (GraphQL)
```

#### ViewModel Pattern

ViewModels extend `Notifier<State>` and are exposed via `NotifierProvider.autoDispose`:

```dart
// product_listing_view_model.dart
class ProductListingViewModel extends Notifier<ProductListingState> {
  @override
  ProductListingState build() {
    // Initialize default state
    // The build() method is called when the provider is first read
    return ProductListingState.initial();
  }

  Future<void> loadProducts({required String categoryId}) async {
    state = state.copyWith(products: const AsyncValue.loading());

    final repository = ref.read(productRepositoryProvider);
    final result = await repository.getProducts(categoryId: categoryId);

    result.when(
      success: (products) {
        state = state.copyWith(
          products: AsyncValue.data(products),
        );
      },
      failure: (error) {
        state = state.copyWith(
          products: AsyncValue.error(error, StackTrace.current),
        );
      },
    );
  }

  void selectProduct(String productId) {
    state = state.copyWith(selectedProductId: productId);
  }
}

// Provider declaration (always autoDispose)
final productListingViewModelProvider =
    NotifierProvider.autoDispose<ProductListingViewModel, ProductListingState>(
  ProductListingViewModel.new,
);
```

#### State Class Pattern

State classes are immutable with `copyWith`:

```dart
// product_listing_state.dart
class ProductListingState {
  final AsyncValue<List<Product>> products;
  final String? selectedProductId;
  final ProductListingId? categoryId;

  const ProductListingState({
    this.products = const AsyncValue.loading(),
    this.selectedProductId,
    this.categoryId,
  });

  factory ProductListingState.initial() => const ProductListingState();

  ProductListingState copyWith({
    AsyncValue<List<Product>>? products,
    String? selectedProductId,
    ProductListingId? categoryId,
  }) {
    return ProductListingState(
      products: products ?? this.products,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
```

### Feature Module Organization

Every feature follows this directory structure:

```
lib/ui/<feature_name>/
├── view/
│   ├── <feature_name>_screen.dart       # Top-level screen widget
│   ├── <feature_name>_content.dart      # Main content widget
│   └── widgets/                         # Feature-specific widgets
│       ├── <widget_name>.dart
│       └── ...
├── view_model/
│   ├── <feature_name>_view_model.dart   # Notifier<State> class
│   ├── <feature_name>_state.dart        # Immutable state with copyWith
│   └── <feature_name>_id.dart           # ID/parameter types (if needed)
```

### State Management

**Core Concepts:**

- **Notifier<State>**: Base class for ViewModels; manages a single state object
- **NotifierProvider.autoDispose**: Exposes the ViewModel; auto-disposes when no longer watched
- **AsyncValue<T>**: Riverpod's tri-state wrapper for async operations (loading, data, error)
- **ref.watch()**: Reactively watches a provider in widgets
- **ref.read()**: Reads a provider value once (use in callbacks, not build methods)
- **ref.listen()**: Listens for state changes with side effects

**Widget Integration:**

Screens use `HookConsumerWidget` to combine Riverpod and Flutter Hooks:

```dart
class ProductListingScreen extends HookConsumerWidget {
  const ProductListingScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productListingViewModelProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(productListingViewModelProvider.notifier)
            .loadProducts(categoryId: categoryId);
      });
      return null;
    }, [categoryId]);

    return state.products.when(
      loading: () => const LoadingIndicator(),
      error: (error, stack) => ErrorWidget(error: error),
      data: (products) => ProductListingContent(products: products),
    );
  }
}
```

---

## Module Structure

```
lib/
├── app/                        # App-level configuration
│   ├── app.dart                # MaterialApp / ProviderScope
│   └── environment.dart        # Environment configuration
├── data/
│   ├── repositories/           # Repository implementations
│   │   ├── product_repository_impl.dart
│   │   └── ...
│   ├── mappers/                # GraphQL → Domain mappers
│   └── local/                  # Hive local storage
├── graphql/
│   ├── queries/                # .graphql query files
│   │   ├── product_queries.graphql
│   │   └── ...
│   ├── schema.graphql          # GraphQL schema
│   └── graphql_executor.dart   # GraphQL client wrapper
├── models/                     # Domain models
│   ├── product.dart
│   └── ...
├── providers/                  # Riverpod providers (DI)
│   ├── repository_providers.dart
│   ├── service_providers.dart
│   └── ...
├── routing/                    # Navigation
│   ├── router.dart             # GoRouter configuration
│   ├── route_registry.dart     # Centralized screen resolution
│   └── routes.dart             # Route path constants
├── ui/
│   ├── core/                   # Design system
│   │   ├── theme/              # AppColors, typography, spacing
│   │   ├── ui/                 # Reusable components
│   │   └── extensions/         # Widget/context extensions
│   ├── product_listing/        # Feature modules
│   │   ├── view/
│   │   └── view_model/
│   ├── product_detail/
│   │   ├── view/
│   │   └── view_model/
│   ├── cart/
│   ├── wishlist/
│   ├── account/
│   └── ...
└── utils/                      # Shared utilities
    ├── extensions/
    └── helpers/
```
