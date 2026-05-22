import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/repositories/brand_repository.dart';
import 'package:alfie_flutter/data/services/graphql_client.dart';
import 'package:alfie_flutter/graphql/generated/queries/brands/brands.graphql.dart';
import 'package:alfie_flutter/utils/error/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockGraphQLClient mockGraphQLClient;
  late MockBrandRepository mockBrandRepository;

  setUpAll(() {
    registerFallbackValue(Options$Query$Brands());
  });

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    mockBrandRepository = MockBrandRepository();
  });

  group('BrandRepository Providers Tests - ', () {
    test('graphQLBrandRepositoryProvider creates GraphQLBrandRepository', () {
      final container = ProviderContainer(
        overrides: [gqlClientProvider.overrideWithValue(mockGraphQLClient)],
      );
      final repository = container.read(graphQLBrandRepositoryProvider);
      expect(repository, isA<GraphQLBrandRepository>());
    });

    test('brandListProvider fetches and returns brands', () async {
      final mockBrands = [MockBrand()];
      when(
        () => mockBrandRepository.getBrands(),
      ).thenAnswer((_) async => mockBrands);

      final container = ProviderContainer(
        overrides: [
          graphQLBrandRepositoryProvider.overrideWithValue(mockBrandRepository),
        ],
      );

      final result = await container.read(brandListProvider.future);
      expect(result, equals(mockBrands));
    });
  });
  group('GraphQLBrandRepository Implementation Tests - ', () {
    late GraphQLBrandRepository repository;

    setUp(() {
      repository = GraphQLBrandRepository(mockGraphQLClient);
    });
    test('getBrands executes query and maps data successfully', () async {
      final successResult = QueryResult<Query$Brands>(
        options: QueryOptions(
          document: gql('query {}'),
          parserFn: (data) => Query$Brands.fromJson(data),
        ),
        source: QueryResultSource.network,
        data: {
          'brands': [
            {
              'id': 'brand-1',
              'name': 'Alfie Brand',
              '__typename': 'Brand',
              'description':
                  'This is a long description to prevent the RangeError in the GraphQLExecutor log statement.',
            },
          ],
          '__typename': 'Query',
        },
      );

      when(
        () => mockGraphQLClient.query<Query$Brands>(any()),
      ).thenAnswer((_) async => successResult);

      final result = await repository.getBrands();

      expect(result, isA<List<Brand>>());
      expect(result.first.id, 'brand-1');
      expect(result.first.name, 'Alfie Brand');

      verify(() => mockGraphQLClient.query<Query$Brands>(any())).called(1);
    });

    test('getBrands throws ServerFailure when GraphQL query fails', () async {
      final exception = OperationException(
        graphqlErrors: [const GraphQLError(message: 'Fetch failed')],
      );

      final failedResult = QueryResult<Query$Brands>(
        options: QueryOptions(
          document: gql('query {}'),
          parserFn: (data) => Query$Brands.fromJson(data),
        ),
        source: QueryResultSource.network,
        exception: exception,
      );

      when(
        () => mockGraphQLClient.query<Query$Brands>(any()),
      ).thenAnswer((_) async => failedResult);

      await expectLater(
        () => repository.getBrands(),
        throwsA(isA<ServerFailure>()),
      );

      verify(() => mockGraphQLClient.query<Query$Brands>(any())).called(1);
    });
  });
}
