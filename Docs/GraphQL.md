# Alfie Flutter — GraphQL Integration

## GraphQL & BFF Integration

> 📚 See `graphql-specialist` agent for the full workflow.

### Overview

The app communicates with the **Alfie BFF** via GraphQL. Queries are in `.graphql` files, processed by `graphql_codegen` to generate type-safe Dart code.

### Structure

```
lib/graphql/
├── queries/               # .graphql query/mutation files
├── fragments/             # Reusable fragment files
├── generated/             # Auto-generated (do not edit)
├── extensions/            # Mapper extensions (toDomain())
├── schema.graphql         # Full schema
└── graphql_executor.dart  # Typed query wrapper
```

### Key Patterns

**Query + Fragment** (`queries/product_queries.graphql`):
```graphql
fragment ProductListItem on Product {
  id
  name
  brand { name }
  price { amount { currencyCode, amount } }
}

query GetProductsByCategory($categoryId: String!, $first: Int) {
  products(categoryId: $categoryId, first: $first) {
    edges { node { ...ProductListItem } }
  }
}
```

**Mapper** (`extensions/product_mapper.dart`):
```dart
extension ProductListItemMapper on Fragment$ProductListItem {
  Product toDomain() => Product(
    id: id, name: name, brand: brand?.name ?? '',
    price: Price(amount: price.amount.amount, currencyCode: price.amount.currencyCode),
  );
}
```

**Repository**: Interface in `data/repositories/`, implementation uses `GraphQLExecutor` for queries with error handling and retry logic.

**Codegen**: `dart run build_runner build --delete-conflicting-outputs`
