import '../../../domain/entities/budget.dart';

/// Abstract class defining local data source operations for budgets
abstract class BudgetLocalDataSource {
  /// Get all cached budgets
  Future<List<Budget>> getCachedBudgets();

  /// Get a specific budget by ID from cache
  Future<Budget> getCachedBudgetById(String id);

  /// Cache a single budget
  Future<void> cacheBudget(Budget budget);

  /// Cache multiple budgets
  Future<void> cacheBudgets(List<Budget> budgets);

  /// Save a budget locally
  Future<void> saveBudget(Budget budget);

  /// Update an existing budget
  Future<void> updateBudget(Budget budget);

  /// Delete a budget
  Future<void> deleteBudget(String id);

  /// Get budgets by period
  Future<List<Budget>> getCachedBudgetsByPeriod(BudgetPeriod period);

  /// Cache budgets by period
  Future<void> cacheBudgetsByPeriod(BudgetPeriod period, List<Budget> budgets);

  /// Get budgets by category
  Future<List<Budget>> getCachedBudgetsByCategory(String categoryId);

  /// Cache budgets by category
  Future<void> cacheBudgetsByCategory(String categoryId, List<Budget> budgets);

  /// Get active budgets
  Future<List<Budget>> getCachedActiveBudgets();

  /// Cache active budgets
  Future<void> cacheActiveBudgets(List<Budget> budgets);

  /// Mark a budget for synchronization
  Future<void> markForSync(String id);

  /// Clear sync mark for a budget
  Future<void> clearSyncMark(String id);

  /// Get budgets marked for sync
  Future<List<Budget>> getBudgetsMarkedForSync();

  /// Mark a budget deletion for sync
  Future<void> markDeletedForSync(String id);

  /// Clear deletion sync mark
  Future<void> clearDeletionSyncMark(String id);

  /// Get budget IDs marked for deletion sync
  Future<List<String>> getDeletionsMarkedForSync();

  /// Clear all cached budgets
  Future<void> clearCache();
}
