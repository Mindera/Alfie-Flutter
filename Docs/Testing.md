# Alfie Flutter — Testing

## Testing

> 📚 See `testing-specialist` agent for detailed test patterns, examples, and workflow.

### Overview

- **Framework**: `flutter_test` (built-in) + `mocktail` for mocking
- **Test Location**: `test/` (mirrors `lib/` structure)
- **Riverpod Testing**: Use `ProviderContainer` with overrides
- **Pattern**: Given-When-Then with `setUp`/`tearDown`

### Running Tests

```bash
flutter test                          # All tests
flutter test test/unit/view_model/    # Specific directory
./test_coverage.sh                    # With coverage
```
