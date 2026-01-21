import 'package:dio/dio.dart';
import 'package:real_time_expense_tracker/core/errors/exceptions.dart';
import 'package:real_time_expense_tracker/data/models/budget_model.dart';
import 'package:real_time_expense_tracker/domain/entities/budget.dart';

import 'budget_remote_data_source.dart';

/// Remote data source implementation using Dio
///
/// Requires:
/// - dio: ^5.4.0
class BudgetRemoteDataSourceImpl implements BudgetRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  BudgetRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
  }) {
    _configureDio();
  }

  void _configureDio() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add interceptors for logging and auth
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if available
          // final token = getAuthToken(); // Implement this
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<List<Budget>> getBudgets() async {
    try {
      final response = await dio.get('/budgets');

      if (response.statusCode == 200) {
        final List<dynamic> budgetsJson =
            response.data['data'] ?? response.data;
        return budgetsJson
            .map((json) => BudgetModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to get budgets: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Budget> getBudgetById(String id) async {
    try {
      final response = await dio.get('/budgets/$id');

      if (response.statusCode == 200) {
        final budgetJson = response.data['data'] ?? response.data;
        return BudgetModel.fromJson(budgetJson).toEntity();
      } else {
        throw ServerException(
          message: 'Failed to get budget: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Budget> createBudget(Budget budget) async {
    try {
      final budgetModel = BudgetModel.fromEntity(budget);
      final response = await dio.post(
        '/budgets',
        data: budgetModel.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final budgetJson = response.data['data'] ?? response.data;
        return BudgetModel.fromJson(budgetJson).toEntity();
      } else {
        throw ServerException(
          message: 'Failed to create budget: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    try {
      final budgetModel = BudgetModel.fromEntity(budget);
      final response = await dio.put(
        '/budgets/${budget.id}',
        data: budgetModel.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException(
          message: 'Failed to update budget: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteBudget(String id) async {
    try {
      final response = await dio.delete('/budgets/$id');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException(
          message: 'Failed to delete budget: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getBudgetsByPeriod(BudgetPeriod period) async {
    try {
      final response = await dio.get(
        '/budgets',
        queryParameters: {'period': period.toString().split('.').last},
      );

      if (response.statusCode == 200) {
        final List<dynamic> budgetsJson =
            response.data['data'] ?? response.data;
        return budgetsJson
            .map((json) => BudgetModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to get budgets by period: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getBudgetsByCategory(String categoryId) async {
    try {
      final response = await dio.get(
        '/budgets',
        queryParameters: {'category_id': categoryId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> budgetsJson =
            response.data['data'] ?? response.data;
        return budgetsJson
            .map((json) => BudgetModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw ServerException(
          message:
              'Failed to get budgets by category: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getActiveBudgets() async {
    try {
      final response = await dio.get(
        '/budgets',
        queryParameters: {'is_active': true},
      );

      if (response.statusCode == 200) {
        final List<dynamic> budgetsJson =
            response.data['data'] ?? response.data;
        return budgetsJson
            .map((json) => BudgetModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to get active budgets: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Budget> toggleBudgetStatus(String id) async {
    try {
      final response = await dio.patch('/budgets/$id/toggle-status');

      if (response.statusCode == 200) {
        final budgetJson = response.data['data'] ?? response.data;
        return BudgetModel.fromJson(budgetJson).toEntity();
      } else {
        throw ServerException(
          message: 'Failed to toggle budget status: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  /// Handle Dio errors and convert them to appropriate exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timeout. Please check your connection.',
        );

      case DioExceptionType.connectionError:
        return ConnectionException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ??
            error.response?.statusMessage ??
            'Server error';

        if (statusCode == 400) {
          return ValidationException(
            message: message,
            errors: error.response?.data?['errors'],
          );
        } else if (statusCode == 401) {
          return UnauthorizedException(message: 'Authentication failed');
        } else if (statusCode == 403) {
          return PermissionDeniedException(message: 'Access denied');
        } else if (statusCode == 404) {
          return NotFoundException(message: 'Resource not found');
        } else if (statusCode == 409) {
          return ConflictException(message: message);
        } else {
          return ServerException(message: 'Server error: $message');
        }

      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');

      case DioExceptionType.badCertificate:
        return ServerException(message: 'Invalid certificate');

      case DioExceptionType.unknown:
        return ServerException(
          message: 'Unknown error occurred: ${error.message}',
        );
    }
  }
}
