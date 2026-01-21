// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

// Base Failure Class with Equatable
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic data;

  const Failure({required this.message, this.code, this.data});

  @override
  List<Object?> get props => [message, code, data];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.code == code &&
        other.data == data;
  }

  @override
  int get hashCode => Object.hash(message, code, data);

  @override
  String toString() =>
      '$runtimeType: $message ${code != null ? '(Code: $code)' : ''}';
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code, super.data});
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure({
    String message = 'Request timeout',
    super.code,
    super.data,
  }) : super(message: message);
}

class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure({
    String message = 'No internet connection',
    super.code,
    super.data,
  }) : super(message: message);
}

class ServerFailure extends NetworkFailure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    this.statusCode,
    super.code,
    super.data,
  });

  @override
  List<Object?> get props => [...super.props, statusCode];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerFailure &&
        super == other &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, statusCode);

  @override
  String toString() =>
      'ServerFailure: $message ${statusCode != null ? '(Status: $statusCode)' : ''}';
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code, super.data});
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure({
    String message = 'Unauthorized access',
    super.code,
    super.data,
  }) : super(message: message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({
    String message = 'Invalid credentials',
    super.code,
    super.data,
  }) : super(message: message);
}

class TokenExpiredFailure extends AuthFailure {
  const TokenExpiredFailure({
    String message = 'Token has expired',
    super.code,
    super.data,
  }) : super(message: message);
}

// Validation Failures
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
    super.code,
    super.data,
  });

  @override
  List<Object?> get props => [...super.props, errors];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValidationFailure &&
        super == other &&
        _mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => Object.hash(super.hashCode, errors);

  @override
  String toString() =>
      'ValidationFailure: $message ${errors != null ? '- Errors: $errors' : ''}';
}

// Data Failures
class DataFailure extends Failure {
  const DataFailure({required super.message, super.code, super.data});
}

class NotFoundFailure extends DataFailure {
  const NotFoundFailure({
    String message = 'Resource not found',
    super.code,
    super.data,
  }) : super(message: message);
}

class DataParsingFailure extends DataFailure {
  const DataParsingFailure({
    String message = 'Failed to parse data',
    super.code,
    super.data,
  }) : super(message: message);
}

class CacheFailure extends DataFailure {
  const CacheFailure({String message = 'Cache error', super.code, super.data})
      : super(message: message);
}

// Storage Failures
class StorageFailure extends Failure {
  const StorageFailure({required super.message, super.code, super.data});
}

class StorageReadFailure extends StorageFailure {
  const StorageReadFailure({
    String message = 'Failed to read from storage',
    super.code,
    super.data,
  }) : super(message: message);
}

class StorageWriteFailure extends StorageFailure {
  const StorageWriteFailure({
    String message = 'Failed to write to storage',
    super.code,
    super.data,
  }) : super(message: message);
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code, super.data});
}

class PermissionDeniedFailure extends PermissionFailure {
  const PermissionDeniedFailure({
    String message = 'Permission denied',
    super.code,
    super.data,
  }) : super(message: message);
}

// File Failures
class FileFailure extends Failure {
  const FileFailure({required super.message, super.code, super.data});
}

class FileNotFoundFailure extends FileFailure {
  const FileNotFoundFailure({
    String message = 'File not found',
    super.code,
    super.data,
  }) : super(message: message);
}

class FileUploadFailure extends FileFailure {
  const FileUploadFailure({
    String message = 'Failed to upload file',
    super.code,
    super.data,
  }) : super(message: message);
}

// Business Logic Failures
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure({required super.message, super.code, super.data});
}

class InvalidOperationFailure extends BusinessLogicFailure {
  const InvalidOperationFailure({
    String message = 'Invalid operation',
    super.code,
    super.data,
  }) : super(message: message);
}

class DuplicateFailure extends BusinessLogicFailure {
  const DuplicateFailure({
    String message = 'Duplicate entry',
    super.code,
    super.data,
  }) : super(message: message);
}

// Keep the specific duplicate expense failure from first code
class DuplicateExpenseFailure extends DuplicateFailure {
  const DuplicateExpenseFailure({
    String message = 'Duplicate expense detected',
    super.code,
    super.data,
  }) : super(message: message);
}

// Unknown Failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'An unknown error occurred',
    super.code,
    super.data,
  }) : super(message: message);
}

// Helper functions for map/list comparison
bool _mapEquals(Map<String, List<String>>? a, Map<String, List<String>>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;

  for (final key in a.keys) {
    if (!b.containsKey(key)) return false;
    if (!_listEquals(a[key], b[key])) return false;
  }
  return true;
}

bool _listEquals(List<String>? a, List<String>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;

  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

// Helper function to convert exceptions to failures
Failure exceptionToFailure(Exception exception) {
  // Add your exception to failure conversion logic here
  // Example:
  // if (exception is NetworkException) {
  //   return NetworkFailure(message: exception.message);
  // }

  return UnknownFailure(message: exception.toString());
}
