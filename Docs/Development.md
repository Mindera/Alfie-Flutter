# Alfie Flutter — Build & Development

## Build & Verification

### Standard Verification

Always run before committing:

```bash
flutter analyze && flutter test
```

### Code Generation

After modifying `.graphql` files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Build Commands

```bash
flutter build apk --release                      # Android APK
flutter build ipa --release --no-codesign         # iOS
./test_coverage.sh                                # Coverage report
```

---

## CI/CD

### GitHub Actions Pipeline

The project uses GitHub Actions with a two-stage pipeline:

**Stage 1: Test & Lint**
- Runs `flutter analyze` for linting
- Runs `dart format --set-exit-if-changed` for format checks
- Runs `flutter test` for all tests
- Triggered on push to `main` and pull requests

**Stage 2: Build**
- Builds Android APK and iOS IPA
- Runs after test-and-lint passes
- Deploys to distribution platform (if on main branch)

### Workflow Files

Located in `.github/workflows/`:
- Test and lint workflow
- Build and deploy workflow

### PR Requirements

- All tests must pass
- Linter must pass with no warnings
- Code must be formatted (`dart format`)
- PR description must follow template in `.github/pull_request_template.md`
