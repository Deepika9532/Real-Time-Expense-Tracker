import 'exceptions.dart';

class ExceptionFactory {
  static TimeoutException timeoutException({String? message}) {
    return TimeoutException(
      message: message ?? 'Request timeout',
    );
  }

  static NoInternetException noInternetException({String? message}) {
    return NoInternetException(
      message: message ?? 'No internet connection',
    );
  }

  static ServerException serverException({
    String? message,
    int? statusCode,
  }) {
    return ServerException(
      message: message ?? 'Server error',
      statusCode: statusCode,
    );
  }

// Add other factories as needed
}
