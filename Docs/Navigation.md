# Alfie Flutter — Navigation

## Navigation

The app uses **GoRouter 17.0.1** with tab-based shell routing (`StatefulShellRoute.indexedStack`) and a **Route Registry** pattern for centralized screen resolution.

### Key Files

- `lib/routing/router.dart` — GoRouter configuration with tab branches
- `lib/routing/route_registry.dart` — Maps routes to screen widgets
- `lib/routing/app_route.dart` — Route enum with paths and children

### Adding a New Route

1. Define route in `app_route.dart`
2. Add `GoRoute` entry in `router.dart` under the appropriate branch
3. Register screen resolution in `route_registry.dart`
4. Create the screen widget in the feature's `view/` directory

### Navigating

```dart
context.push('/product/123');                                    // Push
context.go('/home');                                             // Replace
context.pop();                                                   // Pop
context.pushNamed('productDetail', pathParameters: {'productId': '123'});  // Named
```
