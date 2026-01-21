import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/budget.dart';

/// Abstract repository interface for budget operations
///
/// This repository follows the clean architecture pattern and should be
/// implemented in the data layer (e.g., budget_repository_impl.dart)
abstract class BudgetRepository {
  /// Get all budgets for the current user
  Future<Either<Failure, List<Budget>>> getBudgets();

  /// Get a specific budget by ID
  Future<Either<Failure, Budget>> getBudgetById(String id);

  /// Create a new budget
  Future<Either<Failure, Budget>> createBudget(Budget budget);

  /// Update an existing budget
  Future<Either<Failure, void>> updateBudget(Budget budget);

  /// Delete a budget by ID
  Future<Either<Failure, void>> deleteBudget(String id);

  /// Get budgets by period (monthly, weekly, yearly, custom)
  Future<Either<Failure, List<Budget>>> getBudgetsByPeriod(BudgetPeriod period);

  /// Get budgets by category
  Future<Either<Failure, List<Budget>>> getBudgetsByCategory(String categoryId);

  /// Get active budgets (isActive = true)
  Future<Either<Failure, List<Budget>>> getActiveBudgets();

  /// Toggle budget active status
  Future<Either<Failure, Budget>> toggleBudgetStatus(String id);

  /// Sync budgets with remote server (if applicable)
  Future<Either<Failure, void>> syncBudgets();
}
