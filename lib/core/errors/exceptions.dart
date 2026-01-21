// Base Exception Class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException({required this.message, this.code, this.data});

  @override
  String toString() =>
      // ignore: unnecessary_brace_in_string_interps
      '${runtimeType}: $message${code != null ? ' (Code: $code)' : ''}';
}

// ============ NETWORK EXCEPTIONS ============
abstract class NetworkException extends AppException {
  const NetworkException({required super.message, super.code, super.data});
}

class TimeoutException extends NetworkException {
  const TimeoutException({
    String message = 'Request timeout',
    super.code,
    super.data,
  }) : super(message: message);
}

class NoInternetException extends NetworkException {
  const NoInternetException({
    String message = 'No internet connection',
    super.code,
    super.data,
  }) : super(message: message);
}

class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException({
    required super.message,
    this.statusCode,
    super.code,
    super.data,
  });

  @override
  String toString() =>
      '${super.toString()}${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class ConnectionException extends NetworkException {
  const ConnectionException({
    String message = 'Connection error',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ AUTHENTICATION EXCEPTIONS ============
abstract class AuthenticationException extends AppException {
  const AuthenticationException(
      {required super.message, super.code, super.data});
}

class UnauthorizedException extends AuthenticationException {
  const UnauthorizedException({
    String message = 'Unauthorized access',
    super.code,
    super.data,
  }) : super(message: message);
}

class InvalidCredentialsException extends AuthenticationException {
  const InvalidCredentialsException({
    String message = 'Invalid credentials',
    super.code,
    super.data,
  }) : super(message: message);
}

class TokenExpiredException extends AuthenticationException {
  const TokenExpiredException({
    String message = 'Token has expired',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ VALIDATION EXCEPTIONS ============
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;
  final Map<String, String>? errorMap; // For backward compatibility

  const ValidationException({
    required super.message,
    this.errors,
    this.errorMap,
    super.code,
    super.data,
  });

  @override
  String toString() {
    final base = super.toString();
    if (errors != null && errors!.isNotEmpty) {
      return '$base - Errors: $errors';
    }
    if (errorMap != null && errorMap!.isNotEmpty) {
      return '$base - Errors: $errorMap';
    }
    return base;
  }
}

// ============ DATA EXCEPTIONS ============
abstract class DataException extends AppException {
  const DataException({required super.message, super.code, super.data});
}

class NotFoundException extends DataException {
  const NotFoundException({
    String message = 'Resource not found',
    super.code,
    super.data,
  }) : super(message: message);
}

class ParseException extends DataException {
  const ParseException({
    String message = 'Failed to parse data',
    super.code,
    super.data,
  }) : super(message: message);
}

class DataParsingException extends ParseException {
  const DataParsingException({
    String message = 'Failed to parse data',
    super.code,
    super.data,
  }) : super(message: message);
}

class CacheException extends DataException {
  const CacheException({
    String message = 'Cache error',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ CONFLICT EXCEPTIONS ============
class ConflictException extends DataException {
  const ConflictException({
    String message = 'Conflict occurred',
    super.code,
    super.data,
  }) : super(message: message);
}

class DuplicateException extends ConflictException {
  const DuplicateException({
    String message = 'Duplicate entry',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ STORAGE EXCEPTIONS ============
abstract class StorageException extends AppException {
  const StorageException({required super.message, super.code, super.data});
}

class StorageReadException extends StorageException {
  const StorageReadException({
    String message = 'Failed to read from storage',
    super.code,
    super.data,
  }) : super(message: message);
}

class StorageWriteException extends StorageException {
  const StorageWriteException({
    String message = 'Failed to write to storage',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ PERMISSION EXCEPTIONS ============
abstract class PermissionException extends AppException {
  const PermissionException({required super.message, super.code, super.data});
}

class PermissionDeniedException extends PermissionException {
  const PermissionDeniedException({
    String message = 'Permission denied',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ FILE EXCEPTIONS ============
abstract class FileException extends AppException {
  const FileException({required super.message, super.code, super.data});
}

class FileNotFoundException extends FileException {
  const FileNotFoundException({
    String message = 'File not found',
    super.code,
    super.data,
  }) : super(message: message);
}

class FileUploadException extends FileException {
  const FileUploadException({
    String message = 'Failed to upload file',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ BUSINESS LOGIC EXCEPTIONS ============
abstract class BusinessLogicException extends AppException {
  const BusinessLogicException(
      {required super.message, super.code, super.data});
}

class InvalidOperationException extends BusinessLogicException {
  const InvalidOperationException({
    String message = 'Invalid operation',
    super.code,
    super.data,
  }) : super(message: message);
}

// ============ UNKNOWN EXCEPTION ============
class UnknownException extends AppException {
  const UnknownException({
    String message = 'An unknown error occurred',
    super.code,
    super.data,
  }) : super(message: message);
}
