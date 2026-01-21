import 'package:dartz/dartz.dart';
import '../models/expense_model.dart';
import '../data_sources/local/expense_local_data_source.dart';
import '../data_sources/remote/expense_remote_data_source.dart';
import '../../../core/errors/failures.dart';
import '../../../core/errors/exceptions.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<ExpenseModel>>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  });
  Future<Either<Failure, ExpenseModel>> getExpenseById(String id);
  Future<Either<Failure, ExpenseModel>> createExpense(ExpenseModel expense);
  Future<Either<Failure, ExpenseModel>> updateExpense(ExpenseModel expense);
  Future<Either<Failure, void>> deleteExpense(String id);
  Future<Either<Failure, List<ExpenseModel>>> searchExpenses(String query);
  Future<Either<Failure, void>> syncExpenses();
  Future<Either<Failure, Map<String, double>>> getExpenseStats({
    DateTime? startDate,
    DateTime? endDate,
  });
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  }) async {
    try {
      // Try to get from local first
      final localExpenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
        type: type,
      );

      // Try to sync with remote in background
      _syncInBackground();

      return Right(localExpenses);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> getExpenseById(String id) async {
    try {
      final expense = await localDataSource.getExpenseById(id);
      return Right(expense);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> createExpense(
    ExpenseModel expense,
  ) async {
    try {
      // Save to local first
      final localExpense = await localDataSource.createExpense(expense);

      // Try to sync with remote
      try {
        final remoteExpense = await remoteDataSource.createExpense(
          localExpense,
        );
        // Update local with synced status
        final syncedExpense = localExpense.copyWith(
          id: remoteExpense.id,
          isSynced: true,
        );
        await localDataSource.updateExpense(syncedExpense);
        return Right(syncedExpense);
      } on NetworkException {
        // If network fails, return local expense
        return Right(localExpense);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> updateExpense(
    ExpenseModel expense,
  ) async {
    try {
      // Update local first
      final updatedExpense = expense.copyWith(
        isSynced: false,
        updatedAt: DateTime.now(),
      );
      await localDataSource.updateExpense(updatedExpense);

      // Try to sync with remote
      try {
        await remoteDataSource.updateExpense(updatedExpense);
        final syncedExpense = updatedExpense.copyWith(isSynced: true);
        await localDataSource.updateExpense(syncedExpense);
        return Right(syncedExpense);
      } on NetworkException {
        // If network fails, return local expense
        return Right(updatedExpense);
      }
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      // Delete from local
      await localDataSource.deleteExpense(id);

      // Try to sync with remote
      try {
        await remoteDataSource.deleteExpense(id);
      } on NetworkException {
        // If network fails, mark for deletion sync later
        // You can implement a pending deletions queue here
      }

      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseModel>>> searchExpenses(
    String query,
  ) async {
    try {
      final expenses = await localDataSource.searchExpenses(query);
      return Right(expenses);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncExpenses() async {
    try {
      // Get all unsynced expenses
      final unsyncedExpenses = await localDataSource.getUnsyncedExpenses();

      // Sync each expense
      for (final expense in unsyncedExpenses) {
        try {
          if (expense.createdAt == expense.updatedAt) {
            // New expense
            final remoteExpense = await remoteDataSource.createExpense(expense);
            await localDataSource.updateExpense(
              expense.copyWith(id: remoteExpense.id, isSynced: true),
            );
          } else {
            // Updated expense
            await remoteDataSource.updateExpense(expense);
            await localDataSource.updateExpense(
              expense.copyWith(isSynced: true),
            );
          }
        } catch (e) {
          // Continue with next expense if one fails
          continue;
        }
      }

      // Get remote expenses and update local
      try {
        final remoteExpenses = await remoteDataSource.getExpenses();
        for (final remoteExpense in remoteExpenses) {
          final localExpense = await localDataSource.getExpenseById(
            remoteExpense.id,
          );
          if (localExpense.updatedAt!.isBefore(remoteExpense.updatedAt!)) {
            await localDataSource.updateExpense(remoteExpense);
          }
        }
      } catch (e) {
        // Remote fetch failed, but local sync succeeded
      }

      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getExpenseStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
      );

      double totalExpense = 0;
      double totalIncome = 0;

      for (final expense in expenses) {
        if (expense.type == ExpenseType.expense) {
          totalExpense += expense.amount;
        } else {
          totalIncome += expense.amount;
        }
      }

      final stats = {
        'totalExpense': totalExpense,
        'totalIncome': totalIncome,
        'balance': totalIncome - totalExpense,
        'count': expenses.length.toDouble(),
      };

      return Right(stats);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Helper method for background sync
  void _syncInBackground() {
    syncExpenses().then((result) {
      result.fold(
        (failure) {
          // Log sync failure
          print('Background sync failed: ${failure.message}');
        },
        (_) {
          // Log sync success
          print('Background sync successful');
        },
      );
    });
  }
}
