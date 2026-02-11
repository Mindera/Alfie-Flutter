import 'dart:math' hide log;
import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:alfie_flutter/utils/error/failures.dart';

/// A utility for executing GraphQL operations with automatic retry and error handling.
///
/// This executor provides a consistent way to:
/// - Execute GraphQL queries with proper result validation
/// - Retry on network failures with exponential backoff
/// - Map GraphQL exceptions to domain-level failures
///
/// Example:
/// ```dart
/// final result = await GraphQLExecutor.execute<MyType, MyQuery>(
///   performQuery: () => client.query$MyQuery(...),
///   parseData: (data) => MyType.fromGraphQL(data),
/// );
/// ```
class GraphQLExecutor {
  // Private constructor to prevent instantiation
  GraphQLExecutor._();

  /// Executes a GraphQL query with automatic retries on network failures.
  ///
  /// The [performQuery] function is responsible for executing the actual GraphQL query
  /// and should return a [QueryResult] with the parsed data type [TQuery].
  ///
  /// The [parseData] function transforms the query result into the desired domain type [T].
  ///
  /// Parameters:
  /// - [performQuery]: A function that executes the GraphQL query.
  /// - [parseData]: A function that transforms GraphQL query results to the domain type.
  /// - [maxRetries]: Maximum number of retries on network failures (default: 2).
  ///   Uses exponential backoff: 1s, 2s, 3s, etc.
  ///
  /// Throws:
  /// - [NetworkFailure]: On persistent network errors after retries are exhausted.
  /// - [ServerFailure]: On GraphQL validation errors or when data is null.
  /// - [UnknownFailure]: On unexpected errors.
  static Future<T> execute<T, TQuery>({
    required Future<QueryResult<TQuery>> Function() performQuery,
    required T Function(TQuery data) parseData,
    int maxRetries = 2,
  }) async {
    int attempt = 0;

    while (true) {
      try {
        final result = await performQuery();

        if (result.hasException) {
          throw _mapException(result.exception!);
        }

        final data = result.parsedData;

        log(
          "Recieved raw data from GraphQLExecutor:\n${result.data.toString().substring(0, 100)}...",
        );

        if (data == null) {
          throw const ServerFailure("Data returned null");
        }

        return parseData(data);
      } catch (e) {
        // Only retry on network failures and if retries remain
        if (e is NetworkFailure && attempt < maxRetries) {
          final backoffSeconds = pow(2, attempt).toInt();
          // Exponential backoff: 1s, 2s, 4s...
          await Future.delayed(Duration(seconds: backoffSeconds));
          attempt++;
          continue;
        }

        rethrow;
      }
    }
  }

  /// Maps GraphQL exceptions to domain-level failures.
  ///
  /// Distinguishes between:
  /// - Network/link errors (connectivity, timeouts) → [NetworkFailure]
  /// - GraphQL validation/logic errors from server → [ServerFailure]
  /// - Unexpected errors → [UnknownFailure]
  static Failure _mapException(OperationException exception) {
    if (exception.linkException != null) {
      return NetworkFailure(
        exception.linkException?.originalException?.toString() ??
            "Connection error",
      );
    }

    if (exception.graphqlErrors.isNotEmpty) {
      final error = exception.graphqlErrors.first;
      return ServerFailure(error.message);
    }

    return const UnknownFailure();
  }
}
