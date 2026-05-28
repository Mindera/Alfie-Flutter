# Future Improvements

## Architecture & Scalability
- Standardize Riverpod usage across the app: prefer `ref.watch(provider.select(...))` for narrow rebuilds, avoid `ref.read()` inside `build()`, and centralize side effects in controllers/notifiers.
- Introduce interface-based abstractions for repositories and services so data sources can be swapped without UI changes.

## Maintainability
- Replace inline `TODO` placeholders with issue-backed technical debt items and remove them from production code.
- Use dependency injection or provider factories to keep constructors simple and make unit testing view models and services easier.
- Centralize environment configuration handling and remove asset packaging of `.env` files from release build concerns.

## Testing & Quality Assurance
- Use explicit widget keys and stable selectors in tests to make them robust against layout changes.
