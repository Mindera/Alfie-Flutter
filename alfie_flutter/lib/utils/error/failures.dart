abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = "No internet connection. Please check your network.",
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = "Server error occurred. Please try again later.",
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache failure."]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "An unknown error occurred."]);
}
