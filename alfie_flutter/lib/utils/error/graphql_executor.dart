import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:alfie_flutter/utils/error/failures.dart'; // Adjust your import path

/// A reusable executor for GraphQL operations.
/// Handles:
/// 1. Execution of the query
/// 2. Automatic Retries on Network Failure
/// 3. Exception Mapping to Domain Failures
class GraphQLExecutor {
  // Private constructor to prevent instantiation
  GraphQLExecutor._();

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

        if (result.parsedData == null) {
          throw const ServerFailure("Data returned null");
        }

        return parseData(result.parsedData!);
      } catch (e) {
        // Only retry on NetworkFailures
        if (e is NetworkFailure && attempt < maxRetries) {
          attempt++;
          // Simple exponential backoff: 1s, 2s, 3s...
          await Future.delayed(Duration(seconds: attempt));
          continue;
        }

        // Rethrow if it's not retriable or we ran out of retries
        rethrow;
      }
    }
  }

  static Failure _mapException(OperationException exception) {
    if (exception.linkException != null) {
      // It's a network/link error (offline, timeout, etc.)
      // extracting the original message often gives better info
      return NetworkFailure(
        exception.linkException?.originalException?.toString() ??
            "Connection error",
      );
    }

    if (exception.graphqlErrors.isNotEmpty) {
      // It's a logic error from the server (e.g., validation)
      final error = exception.graphqlErrors.first;
      return ServerFailure(error.message);
    }

    return const UnknownFailure();
  }
}
