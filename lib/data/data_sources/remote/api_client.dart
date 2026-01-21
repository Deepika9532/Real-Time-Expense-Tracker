import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';

class ApiClient {
  late final Dio _dio;
  String? _authToken;

  ApiClient({Dio? dio}) {
    _dio = dio ?? Dio();
    _setupDio();
  }

  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        ApiConstants.headerContentType: ApiConstants.contentTypeJson,
        ApiConstants.headerAccept: ApiConstants.contentTypeJson,
      },
    );

    // Add interceptors
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          if (_authToken != null) {
            options.headers[ApiConstants.headerAuthorization] =
                'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors globally
          final exception = _handleError(error);
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: exception,
            ),
          );
        },
      ),
    );
  }

  // Set auth token
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Clear auth token
  void clearAuthToken() {
    _authToken = null;
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Upload file
  Future<Response> uploadFile(
    String path,
    String filePath, {
    String fileKey = 'file',
    Map<String, dynamic>? additionalData,
    ProgressCallback? onProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(filePath),
        ...?additionalData,
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            ApiConstants.headerContentType: ApiConstants.contentTypeFormData,
          },
        ),
        onSendProgress: onProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Download file
  Future<Response> downloadFile(
    String path,
    String savePath, {
    ProgressCallback? onProgress,
  }) async {
    try {
      final response = await _dio.download(
        path,
        savePath,
        onReceiveProgress: onProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // Handle DioException
  AppException _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timeout. Please check your connection.',
        );

      case DioExceptionType.connectionError:
        return NoInternetException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode, error);

      case DioExceptionType.cancel:
        return ConnectionException(message: 'Request cancelled');

      case DioExceptionType.badCertificate:
        return ServerException(message: 'Invalid certificate');

      case DioExceptionType.unknown:
        return UnknownException(
          message: 'Unknown error occurred: ${error.message}',
        );
    }
  }

  // Handle status codes
  AppException _handleStatusCode(int? statusCode, DioException error) {
    final data = error.response?.data;
    final message = data is Map ? (data['message'] ?? data['error']) : null;

    switch (statusCode) {
      case 400:
        return ValidationException(
          message: message ?? 'Invalid request',
          errors: data is Map ? data['errors'] : null,
          errorMap: data is Map ? _convertErrorsToMap(data['errors']) : null,
        );

      case 401:
        return UnauthorizedException(message: message ?? 'Unauthorized access');

      case 403:
        return PermissionDeniedException(
          message: message ?? 'Access forbidden',
        );

      case 404:
        return NotFoundException(message: message ?? 'Resource not found');

      case 409:
        return ConflictException(message: message ?? 'Conflict occurred');

      case 422:
        return ValidationException(
          message: message ?? 'Validation failed',
          errors: data is Map ? data['errors'] : null,
          errorMap: data is Map ? _convertErrorsToMap(data['errors']) : null,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: message ?? 'Server error',
          statusCode: statusCode,
        );

      default:
        return ServerException(
          message: message ?? 'Server error',
          statusCode: statusCode,
        );
    }
  }

  // Helper method to convert errors format for backward compatibility
  Map<String, String>? _convertErrorsToMap(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      final result = <String, String>{};
      errors.forEach((key, value) {
        if (value is String) {
          result[key] = value;
        } else if (value is List && value.isNotEmpty && value.first is String) {
          result[key] = value.first;
        }
      });
      return result.isNotEmpty ? result : null;
    }
    return null;
  }

  // Handle error (for backward compatibility)
  AppException _handleError(DioException error) {
    return _handleDioException(error);
  }
}
