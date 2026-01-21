import '../../../domain/entities/budget.dart';

/// Abstract class defining remote data source operations for budgets
abstract class BudgetRemoteDataSource {
  /// Get all budgets from the server
  Future<List<Budget>> getBudgets();

  /// Get a specific budget by ID from the server
  Future<Budget> getBudgetById(String id);

  /// Create a new budget on the server
  Future<Budget> createBudget(Budget budget);

  /// Update an existing budget on the server
  Future<void> updateBudget(Budget budget);

  /// Delete a budget from the server
  Future<void> deleteBudget(String id);

  /// Get budgets filtered by period
  Future<List<Budget>> getBudgetsByPeriod(BudgetPeriod period);

  /// Get budgets filtered by category
  Future<List<Budget>> getBudgetsByCategory(String categoryId);

  /// Get only active budgets
  Future<List<Budget>> getActiveBudgets();

  /// Toggle budget active status
  Future<Budget> toggleBudgetStatus(String id);
}
