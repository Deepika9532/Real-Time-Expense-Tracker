import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/expense.dart';

// Type aliases defined outside the class
typedef AddExpenseFunction = Future<Either<Failure, Expense>> Function(
    Expense expense);
typedef CreateExpenseFunction = Future<Either<Failure, Expense>> Function(
    Expense expense);

abstract class ExpenseRepository {
  // ========== CRUD Operations ==========

  /// Create a new expense
  Future<Either<Failure, Expense>> createExpense(Expense expense);

  /// Get a single expense by ID
  Future<Either<Failure, Expense>> getExpenseById(String id);

  /// Update an existing expense
  Future<Either<Failure, Expense>> updateExpense(Expense expense);

  /// Delete a single expense
  Future<Either<Failure, void>> deleteExpense(String id);

  /// Delete multiple expenses
  Future<Either<Failure, void>> deleteMultipleExpenses(List<String> ids);

  /// Check if expense exists
  Future<Either<Failure, bool>> expenseExists(String id);

  // ========== Query Operations ==========

  /// Get all expenses with optional filters
  Future<Either<Failure, List<Expense>>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  });

  /// Get expenses by specific date
  Future<Either<Failure, List<Expense>>> getExpensesByDate(DateTime date);

  /// Get expenses by date range
  Future<Either<Failure, List<Expense>>> getExpensesByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get expenses by category
  Future<Either<Failure, List<Expense>>> getExpensesByCategory(
    String categoryId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get recent expenses
  Future<Either<Failure, List<Expense>>> getRecentExpenses({int limit = 10});

  /// Search expenses by query
  Future<Either<Failure, List<Expense>>> searchExpenses(String query);

  // ========== Aggregation Operations ==========

  /// Get total amount for a period with optional filters
  Future<Either<Failure, double>> getTotalAmount({
    DateTime? startDate,
    DateTime? endDate,
    ExpenseType? type,
  });

  /// Get total expenses by category
  Future<Either<Failure, double>> getTotalExpensesByCategory(String categoryId);

  /// Get expense statistics
  Future<Either<Failure, Map<String, double>>> getExpenseStats({
    DateTime? startDate,
    DateTime? endDate,
  });

  // ========== Sync Operations ==========

  /// Sync local expenses with remote
  Future<Either<Failure, void>> syncExpenses();

  // ========== Helper Methods ==========

  /// Get total expenses (convenience method)
  Future<Either<Failure, double>> getTotalExpenses() {
    return getTotalAmount();
  }

  /// Alias for createExpense (for backward compatibility)
  Future<Either<Failure, Expense>> addExpense(Expense expense) =>
      createExpense(expense);
}
