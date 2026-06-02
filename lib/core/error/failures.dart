/// Base class for all failures in the application
abstract class Failure {
  final String message;
  const Failure(this.message);
  
  @override
  String toString() => message;
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Server/Network-related failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Local cache-related failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network connectivity failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
