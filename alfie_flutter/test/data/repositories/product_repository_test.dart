import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/generated/queries/products/products.graphql.dart';
import 'package:alfie_flutter/utils/error/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockGraphQLClient mockGraphQLClient;
  late MockProductRepository mockProductRepository;

  setUpAll(() {
    // Register fallback values for mocktail's any() matchers using the generated options classes
    registerFallbackValue(
      Options$Query$GetProduct(
        variables: Variables$Query$GetProduct(productId: 'fallback-id'),
      ),
    );
    registerFallbackValue(
      Options$Query$ProductListingQuery(
        variables: Variables$Query$ProductListingQuery(limit: 10, offset: 0),
      ),
    );
  });

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    mockProductRepository = MockProductRepository();
  });

  group('ProductRepository Providers Tests - ', () {
    test(
      'graphQLRepositoryProvider creates GraphQLProductRepository with injected client',
      () {
        final container = ProviderContainer(
          overrides: [gqlClientProvider.overrideWithValue(mockGraphQLClient)],
        );

        final repository = container.read(graphQLRepositoryProvider);

        expect(repository, isA<GraphQLProductRepository>());
      },
    );

    test('getProductProvider fetches product by id from repository', () async {
      final mockProduct = MockProduct();
      when(
        () => mockProductRepository.getProduct('prod-1'),
      ).thenAnswer((_) async => mockProduct);

      final container = ProviderContainer(
        overrides: [
          graphQLRepositoryProvider.overrideWithValue(mockProductRepository),
        ],
      );

      final result = await container.read(getProductProvider('prod-1').future);

      expect(result, equals(mockProduct));
      verify(() => mockProductRepository.getProduct('prod-1')).called(1);
    });

    test(
      'getProductListingProvider fetches listing using params from repository',
      () async {
        final mockListing = MockProductListing();
        final params = ProductListingParams(
          offset: 10,
          limit: 20,
          categoryId: 'cat-1',
        );

        when(
          () => mockProductRepository.getProductListing(
            offset: 10,
            limit: 20,
            categoryId: 'cat-1',
            query: null,
            sort: null,
          ),
        ).thenAnswer((_) async => mockListing);

        final container = ProviderContainer(
          overrides: [
            graphQLRepositoryProvider.overrideWithValue(mockProductRepository),
          ],
        );

        final result = await container.read(
          getProductListingProvider(params).future,
        );

        expect(result, equals(mockListing));
        verify(
          () => mockProductRepository.getProductListing(
            offset: 10,
            limit: 20,
            categoryId: 'cat-1',
            query: null,
            sort: null,
          ),
        ).called(1);
      },
    );
  });

  group('GraphQLProductRepository Implementation Tests - ', () {
    late GraphQLProductRepository repository;

    setUp(() {
      repository = GraphQLProductRepository(mockGraphQLClient);
    });

    group('getProduct - ', () {
      group('getProduct - ', () {
        test('executes query and maps data successfully', () async {
          final successResult = QueryResult<Query$GetProduct>(
            options: QueryOptions(
              document: gql('query {}'),
              parserFn: (data) => Query$GetProduct.fromJson(data),
            ),
            source: QueryResultSource.network,
            data: {
              'product': {
                'id': 'prod-1',
                // 1. Added 'slug' - commonly a required non-nullable String in fragments
                'slug': 'test-product',
                'styleNumber': 'STYLE-123',
                'name': 'Test Product',
                'shortDescription': 'A brief summary of the product.',
                'longDescription':
                    'A detailed description of the product features.',
                'brand': {
                  'id': 'brand-1',
                  'name': 'Alfie Brand',
                  '__typename': 'Brand',
                },
                // 2. Included 'priceRange' with required nested 'low' money object
                'priceRange': {
                  'low': {
                    'amount': 4500,
                    'currencyCode': 'USD',
                    'amountFormatted': '\$45.00',
                    '__typename': 'Money',
                  },
                  '__typename': 'PriceRange',
                },
                'attributes': [],
                'defaultVariant': {
                  'id': 'var-1',
                  'sku': 'SKU-123',
                  'stock': 15,
                  'attributes': [],
                  'price': {
                    'amount': {
                      'amount': 4500,
                      'currencyCode': 'USD',
                      'amountFormatted': '\$45.00',
                      '__typename': 'Money',
                    },
                    '__typename': 'Price',
                  },
                  '__typename': 'ProductVariant',
                },
                'variants': [],
                'colours': [],
                '__typename': 'Product',
                // 3. Padding for GraphQLExecutor logger substring(0, 100)
                'description':
                    'This is a long padding string to ensure the generated JSON string length exceeds 100 characters so the log statement in GraphQLExecutor does not throw a RangeError during unit testing.',
              },
              '__typename': 'Query',
            },
          );

          when(
            () => mockGraphQLClient.query<Query$GetProduct>(any()),
          ).thenAnswer((_) async => successResult);

          final result = await repository.getProduct('prod-1');

          expect(result, isNotNull);
          expect(result?.id, 'prod-1');
          expect(result?.styleNumber, 'STYLE-123');

          verify(
            () => mockGraphQLClient.query<Query$GetProduct>(any()),
          ).called(1);
        });
        test('throws ServerFailure when GraphQL query fails', () async {
          final exception = OperationException(
            graphqlErrors: [
              const GraphQLError(message: 'Product fetch failed'),
            ],
          );

          final failedResult = QueryResult<Query$GetProduct>(
            options: QueryOptions(
              document: gql('query {}'),
              parserFn: (data) => Query$GetProduct.fromJson(data),
            ),
            source: QueryResultSource.network,
            exception: exception,
          );

          when(
            () => mockGraphQLClient.query<Query$GetProduct>(any()),
          ).thenAnswer((_) async => failedResult);

          await expectLater(
            () => repository.getProduct('prod-1'),
            throwsA(isA<ServerFailure>()),
          );
        });
      });
    });
    group('getProductListing - ', () {
      test('executes query and maps data successfully', () async {
        final successResult = QueryResult<Query$ProductListingQuery>(
          options: QueryOptions(
            document: gql('query {}'),
            parserFn: (data) => Query$ProductListingQuery.fromJson(data),
          ),
          source: QueryResultSource.network,
          data: {
            'productListing': {
              'title': 'All Products',
              'pagination': {
                'offset': 0,
                'limit': 10,
                'total': 50,
                'pages': 5,
                'page': 1,
                'previousPage': null, // Map key matches pagination_mapper.dart
                'nextPage': 2,
                '__typename': 'Pagination',
              },
              'products': [], // Must be an array, not null
              '__typename': 'ProductListing',
              'description':
                  'Padding string for logger: This ensures that the JSON stringified version of this data map is long enough to satisfy the substring(0, 100) call in the GraphQLExecutor class.',
            },
            '__typename': 'Query',
          },
        );

        when(
          () => mockGraphQLClient.query<Query$ProductListingQuery>(any()),
        ).thenAnswer((_) async => successResult);

        final result = await repository.getProductListing(
          offset: 0,
          limit: 10,
          sort: ProductListingSort.lowToHigh,
          query: 'shoes',
        );

        expect(result, isNotNull);
        expect(result?.title, 'All Products');
        verify(
          () => mockGraphQLClient.query<Query$ProductListingQuery>(any()),
        ).called(1);
      });

      group('ProductListingParams Tests - ', () {
        test('equality and hashCode work properly', () {
          final params1 = ProductListingParams(
            offset: 0,
            limit: 10,
            categoryId: 'cat1',
          );
          final params2 = ProductListingParams(
            offset: 0,
            limit: 10,
            categoryId: 'cat1',
          );
          final params3 = ProductListingParams(
            offset: 10,
            limit: 10,
            categoryId: 'cat1',
          );

          expect(params1, equals(params2));
          expect(params1.hashCode, equals(params2.hashCode));
          expect(params1, isNot(equals(params3)));
        });

        test('copyWith updates fields while retaining others', () {
          final original = ProductListingParams(
            offset: 0,
            limit: 10,
            categoryId: 'cat1',
          );

          final updated = original.copyWith(offset: 20, query: 'shoes');

          expect(updated.offset, 20);
          expect(updated.limit, 10);
          expect(updated.categoryId, 'cat1');
          expect(updated.query, 'shoes');
          expect(updated.sort, isNull);
        });
        test('copyWith updates fields while retaining others 2', () {
          final original = ProductListingParams(
            offset: 0,
            limit: 10,
            categoryId: 'cat1',
          );

          final updated = original.copyWith(limit: 20, categoryId: 'shoes');

          expect(updated.offset, 0);
          expect(updated.limit, 20);
          expect(updated.categoryId, 'shoes');
          expect(updated.query, isNull);
          expect(updated.sort, isNull);
        });
      });
    });
  });
}
