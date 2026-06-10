/// Base class for all failures in the application.
///
/// Implements [Exception] so a domain [Failure] can be carried inside the
/// `Result.Failure(Exception)` wrapper from `result.dart` without losing its
/// type (the two `Failure` names are disambiguated via import aliasing).
abstract class Failure implements Exception {
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
