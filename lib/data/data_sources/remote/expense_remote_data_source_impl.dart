import 'package:real_time_expense_tracker/core/errors/exceptions.dart';
import '../../models/expense_model.dart';
import 'api_client.dart';
import 'expense_remote_data_source.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final ApiClient apiClient;

  ExpenseRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ExpenseModel>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }
      if (categoryId != null) {
        queryParams['categoryId'] = categoryId;
      }
      if (type != null) {
        queryParams['type'] = type.name;
      }

      final response = await apiClient.get(
        '/expenses',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data.map((json) => ExpenseModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch expenses',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ConnectionException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<ExpenseModel> getExpenseById(String id) async {
    try {
      final response = await apiClient.get('/expenses/$id');

      if (response.statusCode == 200) {
        return ExpenseModel.fromJson(response.data['data'] ?? response.data);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Expense not found');
      } else {
        throw ServerException(
          message: 'Failed to fetch expense',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw ConnectionException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<ExpenseModel> createExpense(ExpenseModel expense) async {
    try {
      final response = await apiClient.post(
        '/expenses',
        data: expense.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ExpenseModel.fromJson(response.data['data'] ?? response.data);
      } else if (response.statusCode == 400) {
        throw ValidationException(
          message: 'Invalid expense data',
          errors: response.data['errors'],
        );
      } else {
        throw ServerException(
          message: 'Failed to create expense',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on ValidationException {
      rethrow;
    } catch (e) {
      throw ConnectionException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<ExpenseModel> updateExpense(ExpenseModel expense) async {
    try {
      final response = await apiClient.put(
        '/expenses/${expense.id}',
        data: expense.toJson(),
      );

      if (response.statusCode == 200) {
        return ExpenseModel.fromJson(response.data['data'] ?? response.data);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Expense not found');
      } else if (response.statusCode == 400) {
        throw ValidationException(
          message: 'Invalid expense data',
          errors: response.data['errors'],
        );
      } else {
        throw ServerException(
          message: 'Failed to update expense',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } on ValidationException {
      rethrow;
    } catch (e) {
      throw ConnectionException(message: 'Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      final response = await apiClient.delete('/expenses/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Expense not found');
      } else {
        throw ServerException(
          message: 'Failed to delete expense',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw ConnectionException(message: 'Network error: ${e.toString()}');
    }
  }
}
