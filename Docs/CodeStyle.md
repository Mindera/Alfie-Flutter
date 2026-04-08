# Alfie Flutter — Code Style & Conventions

## Design System

### Location

The design system lives in `lib/ui/core/`:

```
lib/ui/core/
├── theme/
│   ├── app_colors.dart          # Brand colors, semantic colors
│   ├── app_typography.dart      # Text styles (heading, body, caption, etc.)
│   ├── app_spacing.dart         # Spacing constants (4, 8, 12, 16, 24, 32, 48)
│   ├── app_theme.dart           # ThemeData configuration
│   └── app_shadows.dart         # Box shadow definitions
├── ui/
│   ├── buttons/                 # PrimaryButton, SecondaryButton, IconButton
│   ├── cards/                   # ProductCard, CategoryCard, etc.
│   ├── inputs/                  # TextFields, SearchBar, Dropdown
│   ├── indicators/              # LoadingIndicator, ProgressBar
│   ├── dialogs/                 # AlertDialog, BottomSheet
│   └── ...
└── extensions/
    ├── context_extensions.dart  # Theme/MediaQuery shortcuts
    └── widget_extensions.dart   # Padding/alignment helpers
```

### Usage Guidelines

- **Always** use existing design system components before creating new ones
- **Always** use `AppColors`, `AppTypography`, and `AppSpacing` instead of raw values
- If a new component is needed, add it to `lib/ui/core/ui/` following existing patterns
- Use `Theme.of(context)` for accessing theme data in widgets

```dart
// ✅ Good — uses design system
Text(
  'Product Name',
  style: AppTypography.headingMedium,
)

// ❌ Bad — hardcoded values
Text(
  'Product Name',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

### Component Conventions

- Components are stateless where possible
- Accept callbacks for user interaction (onTap, onChanged)
- Use `const` constructors
- Expose `Key` parameter via `super.key`
- Follow existing naming: `App<ComponentType>` (e.g., `AppButton`, `AppCard`)

---

## Dependency Injection

### Riverpod Providers

The project uses **Riverpod providers** for dependency injection (no `get_it` or service locators):

```dart
// repository_providers.dart
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final executor = ref.watch(graphQLExecutorProvider);
  return ProductRepositoryImpl(executor);
});

// service_providers.dart
final graphQLExecutorProvider = Provider<GraphQLExecutor>((ref) {
  return GraphQLExecutor(client: ref.watch(graphQLClientProvider));
});

final hiveStorageProvider = Provider<HiveStorage>((ref) {
  return HiveStorage();
});
```

### Provider Organization

```
lib/providers/
├── repository_providers.dart    # All repository providers
├── service_providers.dart       # Infrastructure service providers
├── graphql_providers.dart       # GraphQL client and executor
└── storage_providers.dart       # Hive and local storage providers
```

### Best Practices

- Providers are declared as top-level `final` variables
- Use `Provider` for services and repositories
- Use `NotifierProvider.autoDispose` for ViewModels
- Use `FutureProvider.autoDispose` for one-shot async data
- Use `ref.watch()` for reactive dependencies between providers
- Override providers in tests using `ProviderContainer`

---

## Code Style & Best Practices

### Linting

The project uses **flutter_lints 6.0.0** and **riverpod_lint** configured in `analysis_options.yaml`.

```bash
# Run linter
flutter analyze

# Format code
dart format lib/ test/

# Format check (CI)
dart format --set-exit-if-changed lib/ test/
```

### Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Files | `snake_case` | `product_listing_screen.dart` |
| Classes | `PascalCase` | `ProductListingScreen` |
| Variables / Functions | `camelCase` | `loadProducts()` |
| Constants | `camelCase` | `defaultPageSize` |
| Enums | `PascalCase` (type) / `camelCase` (values) | `ProductSort.priceLowToHigh` |
| Providers | `camelCase` + `Provider` suffix | `productRepositoryProvider` |
| Private members | `_camelCase` | `_loadInitialData()` |
| Type parameters | Single uppercase letter | `Result<T>` |

### Widget Best Practices

```dart
// ✅ Use const constructors
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    // ...
  }
}

// ✅ Use const where possible
const SizedBox(height: AppSpacing.medium),
const Divider(),

// ✅ Extract widgets into separate classes for reusability
// ✅ Use super.key instead of Key? key
// ✅ Prefer final fields
// ✅ Use named parameters with required keyword
```

### Import Organization

```dart
// 1. Dart SDK imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Third-party packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 4. Project imports (relative)
import '../view_model/product_listing_view_model.dart';
import '../../core/ui/buttons/primary_button.dart';
```

### Error Handling

- Use `AsyncValue` for all async state (never raw try/catch in widgets)
- Use a `Result<T>` type in repositories for explicit success/failure
- Handle all three states in UI: loading, data, error
- Log errors appropriately; never swallow exceptions silently
