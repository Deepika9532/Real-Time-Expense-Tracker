import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../data_sources/local/budget_local_data_source.dart';
import '../data_sources/remote/budget_remote_data_source.dart';

/// Implementation of BudgetRepository
///
/// This repository implements the clean architecture pattern by:
/// - Using local data source for offline access
/// - Using remote data source for server sync
/// - Handling network connectivity
/// - Converting exceptions to failures
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource localDataSource;
  final BudgetRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BudgetRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Budget>>> getBudgets() async {
    try {
      // Try to get from remote if connected
      if (await networkInfo.isConnected) {
        try {
          final remoteBudgets = await remoteDataSource.getBudgets();
          // Cache the remote data locally
          await localDataSource.cacheBudgets(remoteBudgets);
          return Right(remoteBudgets);
        } on ServerException {
          // If remote fails, fall back to local cache
          final localBudgets = await localDataSource.getCachedBudgets();
          return Right(localBudgets);
        }
      } else {
        // No internet, use local cache
        final localBudgets = await localDataSource.getCachedBudgets();
        return Right(localBudgets);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to get budgets: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Budget>> getBudgetById(String id) async {
    try {
      // Try remote first if connected
      if (await networkInfo.isConnected) {
        try {
          final budget = await remoteDataSource.getBudgetById(id);
          // Cache it locally
          await localDataSource.cacheBudget(budget);
          return Right(budget);
        } on ServerException {
          // Fall back to local
          final budget = await localDataSource.getCachedBudgetById(id);
          return Right(budget);
        }
      } else {
        // Use local cache
        final budget = await localDataSource.getCachedBudgetById(id);
        return Right(budget);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to get budget: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Budget>> createBudget(Budget budget) async {
    try {
      // Save locally first for immediate feedback
      await localDataSource.saveBudget(budget);

      // Try to sync with remote if connected
      if (await networkInfo.isConnected) {
        try {
          final createdBudget = await remoteDataSource.createBudget(budget);
          // Update local cache with server response
          await localDataSource.updateBudget(createdBudget);
          return Right(createdBudget);
        } on ServerException {
          // Local save succeeded, but remote failed - mark for sync
          await localDataSource.markForSync(budget.id);
          return Right(budget);
        }
      } else {
        // No internet - mark for sync later
        await localDataSource.markForSync(budget.id);
        return Right(budget);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to create budget: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBudget(Budget budget) async {
    try {
      // Update locally first
      await localDataSource.updateBudget(budget);

      // Try to sync with remote if connected
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.updateBudget(budget);
        } on ServerException {
          // Local update succeeded, but remote failed - mark for sync
          await localDataSource.markForSync(budget.id);
        }
      } else {
        // No internet - mark for sync later
        await localDataSource.markForSync(budget.id);
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to update budget: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBudget(String id) async {
    try {
      // Delete locally first
      await localDataSource.deleteBudget(id);

      // Try to delete from remote if connected
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.deleteBudget(id);
        } on ServerException {
          // Local delete succeeded, but remote failed - mark for sync
          await localDataSource.markDeletedForSync(id);
        }
      } else {
        // No internet - mark for sync later
        await localDataSource.markDeletedForSync(id);
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to delete budget: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Budget>>> getBudgetsByPeriod(
      BudgetPeriod period) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final budgets = await remoteDataSource.getBudgetsByPeriod(period);
          // Cache the results
          await localDataSource.cacheBudgetsByPeriod(period, budgets);
          return Right(budgets);
        } on ServerException {
          // Fall back to local
          final budgets =
              await localDataSource.getCachedBudgetsByPeriod(period);
          return Right(budgets);
        }
      } else {
        final budgets = await localDataSource.getCachedBudgetsByPeriod(period);
        return Right(budgets);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to get budgets by period: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Budget>>> getBudgetsByCategory(
      String categoryId) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final budgets =
              await remoteDataSource.getBudgetsByCategory(categoryId);
          // Cache the results
          await localDataSource.cacheBudgetsByCategory(categoryId, budgets);
          return Right(budgets);
        } on ServerException {
          // Fall back to local
          final budgets =
              await localDataSource.getCachedBudgetsByCategory(categoryId);
          return Right(budgets);
        }
      } else {
        final budgets =
            await localDataSource.getCachedBudgetsByCategory(categoryId);
        return Right(budgets);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to get budgets by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Budget>>> getActiveBudgets() async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final budgets = await remoteDataSource.getActiveBudgets();
          // Cache the results
          await localDataSource.cacheActiveBudgets(budgets);
          return Right(budgets);
        } on ServerException {
          // Fall back to local
          final budgets = await localDataSource.getCachedActiveBudgets();
          return Right(budgets);
        }
      } else {
        final budgets = await localDataSource.getCachedActiveBudgets();
        return Right(budgets);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to get active budgets: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Budget>> toggleBudgetStatus(String id) async {
    try {
      // Get current budget
      final budgetResult = await getBudgetById(id);

      return budgetResult.fold(
        (failure) => Left(failure),
        (budget) async {
          // Toggle the status
          final updatedBudget = budget.copyWith(isActive: !budget.isActive);

          // Update locally
          await localDataSource.updateBudget(updatedBudget);

          // Try to sync with remote
          if (await networkInfo.isConnected) {
            try {
              final remoteBudget =
                  await remoteDataSource.toggleBudgetStatus(id);
              await localDataSource.updateBudget(remoteBudget);
              return Right(remoteBudget);
            } on ServerException {
              // Mark for sync
              await localDataSource.markForSync(id);
              return Right(updatedBudget);
            }
          } else {
            await localDataSource.markForSync(id);
            return Right(updatedBudget);
          }
        },
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to toggle budget status: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> syncBudgets() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      // Get budgets marked for sync
      final budgetsToSync = await localDataSource.getBudgetsMarkedForSync();

      // Sync each budget
      for (final budget in budgetsToSync) {
        try {
          await remoteDataSource.updateBudget(budget);
          await localDataSource.clearSyncMark(budget.id);
        } on ServerException {
          // Continue with other budgets even if one fails
          continue;
        }
      }

      // Get deletions marked for sync
      final deletionsToSync = await localDataSource.getDeletionsMarkedForSync();

      // Sync each deletion
      for (final id in deletionsToSync) {
        try {
          await remoteDataSource.deleteBudget(id);
          await localDataSource.clearDeletionSyncMark(id);
        } on ServerException {
          // Continue with other deletions
          continue;
        }
      }

      // Fetch latest from server to ensure consistency
      final remoteBudgets = await remoteDataSource.getBudgets();
      await localDataSource.cacheBudgets(remoteBudgets);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to sync budgets: ${e.toString()}'));
    }
  }
}
