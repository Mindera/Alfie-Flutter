npx get-graphql-schema http://localhost:4000/ > lib/data/services/schema.graphql
dart run build_runner build --delete-conflicting-outputs