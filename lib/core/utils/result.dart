// A simple Result type for error handling
// Represents either a success with data or a failure with an error


sealed class Result<T> {
  const Result();
}

/// Success result containing data
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Failure result containing an error
class Failure<T> extends Result<T> {
  final Exception error;
  const Failure(this.error);
}
