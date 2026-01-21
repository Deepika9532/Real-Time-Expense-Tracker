import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../data_sources/local/expense_local_data_source.dart';
import '../models/expense_model.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, Map<String, double>>> getCategoryWiseExpenses({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Either<Failure, Map<String, double>>> getMonthlyExpenses(int year);
  Future<Either<Failure, Map<String, double>>> getDailyExpenses(DateTime month);
  Future<Either<Failure, List<CategoryExpense>>> getTopCategories({
    DateTime? startDate,
    DateTime? endDate,
    int limit = 5,
  });
  Future<Either<Failure, Map<String, dynamic>>> getExpenseTrends({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Either<Failure, Map<String, dynamic>>> getIncomeVsExpense({
    DateTime? startDate,
    DateTime? endDate,
  });
}

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final ExpenseLocalDataSource localDataSource;

  AnalyticsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Map<String, double>>> getCategoryWiseExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        type: ExpenseType.expense,
      );

      final Map<String, double> categoryExpenses = {};

      for (final expense in expenses) {
        categoryExpenses[expense.categoryId] =
            (categoryExpenses[expense.categoryId] ?? 0) + expense.amount;
      }

      return Right(categoryExpenses);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getMonthlyExpenses(
    int year,
  ) async {
    try {
      final startDate = DateTime(year, 1, 1);
      final endDate = DateTime(year, 12, 31, 23, 59, 59);

      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        type: ExpenseType.expense,
      );

      final Map<String, double> monthlyExpenses = {};

      for (int i = 1; i <= 12; i++) {
        monthlyExpenses['Month $i'] = 0;
      }

      for (final expense in expenses) {
        final monthKey = 'Month ${expense.date.month}';
        monthlyExpenses[monthKey] =
            (monthlyExpenses[monthKey] ?? 0) + expense.amount;
      }

      return Right(monthlyExpenses);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getDailyExpenses(
    DateTime month,
  ) async {
    try {
      final startDate = DateTime(month.year, month.month, 1);
      final endDate = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        type: ExpenseType.expense,
      );

      final Map<String, double> dailyExpenses = {};
      final daysInMonth = endDate.day;

      for (int i = 1; i <= daysInMonth; i++) {
        dailyExpenses['Day $i'] = 0;
      }

      for (final expense in expenses) {
        final dayKey = 'Day ${expense.date.day}';
        dailyExpenses[dayKey] = (dailyExpenses[dayKey] ?? 0) + expense.amount;
      }

      return Right(dailyExpenses);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryExpense>>> getTopCategories({
    DateTime? startDate,
    DateTime? endDate,
    int limit = 5,
  }) async {
    try {
      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        type: ExpenseType.expense,
      );

      final Map<String, CategoryExpense> categoryMap = {};

      for (final expense in expenses) {
        if (categoryMap.containsKey(expense.categoryId)) {
          final current = categoryMap[expense.categoryId]!;
          categoryMap[expense.categoryId] = CategoryExpense(
            categoryId: expense.categoryId,
            totalAmount: current.totalAmount + expense.amount,
            count: current.count + 1,
          );
        } else {
          categoryMap[expense.categoryId] = CategoryExpense(
            categoryId: expense.categoryId,
            totalAmount: expense.amount,
            count: 1,
          );
        }
      }

      final sortedCategories = categoryMap.values.toList()
        ..sort((a, b) => b.totalAmount.compareTo(a.totalAmount));

      final topCategories = sortedCategories.take(limit).toList();

      return Right(topCategories);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getExpenseTrends({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final expenses = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
        type: ExpenseType.expense,
      );

      if (expenses.isEmpty) {
        return Right({
          'averageExpense': 0.0,
          'highestExpense': 0.0,
          'lowestExpense': 0.0,
          'totalExpense': 0.0,
          'trend': 'stable',
        });
      }

      double total = 0;
      double highest = expenses.first.amount;
      double lowest = expenses.first.amount;

      for (final expense in expenses) {
        total += expense.amount;
        if (expense.amount > highest) highest = expense.amount;
        if (expense.amount < lowest) lowest = expense.amount;
      }

      final average = total / expenses.length;

      // Calculate trend (simplified)
      final firstHalf = expenses.take(expenses.length ~/ 2);
      final secondHalf = expenses.skip(expenses.length ~/ 2);

      final firstHalfTotal = firstHalf.fold(0.0, (sum, e) => sum + e.amount);
      final secondHalfTotal = secondHalf.fold(0.0, (sum, e) => sum + e.amount);

      String trend = 'stable';
      if (secondHalfTotal > firstHalfTotal * 1.1) {
        trend = 'increasing';
      } else if (secondHalfTotal < firstHalfTotal * 0.9) {
        trend = 'decreasing';
      }

      return Right({
        'averageExpense': average,
        'highestExpense': highest,
        'lowestExpense': lowest,
        'totalExpense': total,
        'trend': trend,
      });
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getIncomeVsExpense({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final allTransactions = await localDataSource.getExpenses(
        startDate: startDate,
        endDate: endDate,
      );

      double totalIncome = 0;
      double totalExpense = 0;
      int incomeCount = 0;
      int expenseCount = 0;

      for (final transaction in allTransactions) {
        if (transaction.type == ExpenseType.income) {
          totalIncome += transaction.amount;
          incomeCount++;
        } else {
          totalExpense += transaction.amount;
          expenseCount++;
        }
      }

      final balance = totalIncome - totalExpense;
      final savingsRate = totalIncome > 0
          ? ((totalIncome - totalExpense) / totalIncome * 100)
          : 0.0;

      return Right({
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'balance': balance,
        'incomeCount': incomeCount,
        'expenseCount': expenseCount,
        'savingsRate': savingsRate,
      });
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

// Helper class for category expenses
class CategoryExpense {
  final String categoryId;
  final double totalAmount;
  final int count;

  CategoryExpense({
    required this.categoryId,
    required this.totalAmount,
    required this.count,
  });

  double get averageAmount => count > 0 ? totalAmount / count : 0;
}
