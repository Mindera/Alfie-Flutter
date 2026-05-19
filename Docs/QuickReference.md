# Alfie Flutter — Quick Reference

## Things to Avoid

❌ Use `setState()` or `ChangeNotifier` — use Riverpod `Notifier` + `ref.watch()`
❌ Use `get_it` or service locators — use Riverpod providers
❌ Hardcode colors/typography — use `AppColors` and `AppTypography`
❌ Edit generated files (`*.g.dart`, `*.graphql.dart`)
❌ Use `BuildContext` in ViewModels
❌ Store secrets in code — use environment variables or secure storage
❌ Use `dynamic` types — always specify types explicitly
❌ Use mutable state classes — state must be immutable with `copyWith`
❌ Ignore `flutter analyze` warnings

---

## Quick Reference

### Key Directories

| Directory | Purpose |
|---|---|
| `lib/ui/` | Feature modules (view + view_model) |
| `lib/ui/core/` | Design system (theme, components) |
| `lib/data/` | Repository implementations, mappers |
| `lib/graphql/queries/` | GraphQL query/mutation files |
| `lib/models/` | Domain models |
| `lib/providers/` | Riverpod provider declarations |
| `lib/routing/` | GoRouter config and Route Registry |
| `test/` | All tests (unit, widget) |

### Common Commands

```bash
# Analyze code
flutter analyze

# Run all tests
flutter test

# Format code
dart format lib/ test/

# Generate GraphQL code
dart run build_runner build --delete-conflicting-outputs

# Run coverage
./test_coverage.sh

# Full verification
flutter analyze && flutter test

# Build Android
flutter build apk --release

# Build iOS
flutter build ipa --release --no-codesign
```

### New Feature Checklist

> 📚 See `feature-orchestrator` agent for the full 8-phase lifecycle and `feature-developer` for implementation workflow.
