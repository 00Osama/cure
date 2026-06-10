import 'package:dio/dio.dart';

import '../utils/failures.dart';

/// Maps any error thrown by the network layer into a domain [Failure].
///
/// Centralizing this keeps repositories free of Dio-specific knowledge and
/// guarantees consistent, user-facing error messages.
Failure mapDioError(Object error) {
  if (error is Failure) return error;
  if (error is! DioException) {
    return ServerFailure('Unexpected error: $error');
  }

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure('No internet connection. Please try again.');
    case DioExceptionType.cancel:
      return const NetworkFailure('Request was cancelled.');
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode ?? 0;
      if (status == 401 || status == 403) {
        return AuthFailure('Not authorized ($status).');
      }
      return ServerFailure(_serverMessage(error.response?.data, status));
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return ServerFailure('Request failed: ${error.message ?? 'unknown'}');
  }
}

String _serverMessage(dynamic data, int status) {
  if (data is Map) {
    final msg = data['message'] ?? data['error'] ?? data['hint'];
    if (msg != null) return msg.toString();
  }
  return 'Server error ($status).';
}
