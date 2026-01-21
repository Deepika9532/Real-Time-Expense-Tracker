import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

abstract class AnalyticsRepository {
  /// Get expenses grouped by category
  Future<Either<Failure, Map<String, double>>> getCategoryWiseExpenses({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get monthly expenses for a year
  Future<Either<Failure, Map<String, double>>> getMonthlyExpenses(int year);

  /// Get daily expenses for a month
  Future<Either<Failure, Map<String, double>>> getDailyExpenses(DateTime month);

  /// Get top spending categories
  Future<Either<Failure, List<CategoryExpense>>> getTopCategories({
    DateTime? startDate,
    DateTime? endDate,
    int limit = 5,
  });

  /// Get expense trends
  Future<Either<Failure, Map<String, dynamic>>> getExpenseTrends({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get income vs expense comparison
  Future<Either<Failure, Map<String, dynamic>>> getIncomeVsExpense({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get spending by time of day
  Future<Either<Failure, Map<String, double>>> getSpendingByTimeOfDay({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get spending by day of week
  Future<Either<Failure, Map<String, double>>> getSpendingByDayOfWeek({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get average daily spending
  Future<Either<Failure, double>> getAverageDailySpending({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get spending forecast for next period
  Future<Either<Failure, Map<String, double>>> getSpendingForecast({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get budget utilization
  Future<Either<Failure, Map<String, dynamic>>> getBudgetUtilization({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get payment method breakdown
  Future<Either<Failure, Map<String, double>>> getPaymentMethodBreakdown({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get year-over-year comparison
  Future<Either<Failure, Map<String, dynamic>>> getYearOverYearComparison({
    required int year1,
    required int year2,
  });

  /// Export analytics data
  Future<Either<Failure, String>> exportAnalyticsData({
    DateTime? startDate,
    DateTime? endDate,
    String format = 'csv',
  });
}

/// Helper class for category expense data
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
