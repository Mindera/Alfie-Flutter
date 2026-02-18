/// Base class for domain-level failures in the application.
///
/// This is used to represent errors that have been categorized and processed
/// by the application, as opposed to raw exceptions. Failures provide a
/// user-friendly message and are handled consistently across the app.
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// Represents network-related failures (connectivity, timeouts, offline state).
///
/// This failure type is used when the device cannot reach the server or
/// the connection is lost during an operation.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = "No internet connection. Please check your network.",
  ]);
}

/// Represents server-side errors (validation, business logic, etc.).
///
/// This failure type indicates that the request reached the server but was
/// rejected due to validation errors, missing data, or other business logic constraints.
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = "Server error occurred. Please try again later.",
  ]);
}

/// Represents unexpected or unhandled errors.
///
/// This failure type is used as a catch-all for errors that don't fit into
/// other categories and should rarely occur in normal operation.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "An unknown error occurred."]);
}
