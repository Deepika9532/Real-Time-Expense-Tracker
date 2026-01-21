import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/analytics_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class GetAnalytics implements UseCase<AnalyticsData, GetAnalyticsParams> {
  final AnalyticsRepository repository;

  GetAnalytics(this.repository);

  @override
  Future<Either<Failure, AnalyticsData>> call(GetAnalyticsParams params) async {
    // Get all analytics data in parallel
    final results = await Future.wait([
      repository.getCategoryWiseExpenses(
        startDate: params.startDate,
        endDate: params.endDate,
      ),
      repository.getTopCategories(
        startDate: params.startDate,
        endDate: params.endDate,
        limit: params.topCategoriesLimit,
      ),
      repository.getExpenseTrends(
        startDate: params.startDate,
        endDate: params.endDate,
      ),
      repository.getIncomeVsExpense(
        startDate: params.startDate,
        endDate: params.endDate,
      ),
    ]);

    // Check if any request failed
    for (var result in results) {
      if (result.isLeft()) {
        return result.fold(
          (failure) => Left(failure),
          (_) => const Left(UnknownFailure(message: 'Unknown error')),
        );
      }
    }

    // Extract successful results
    final categoryWiseExpenses = results[0].getOrElse(() => <String, double>{});
    final topCategories = results[1].getOrElse(() => <CategoryExpense>[]);
    final expenseTrends = results[2].getOrElse(() => <String, dynamic>{});
    final incomeVsExpense = results[3].getOrElse(() => <String, dynamic>{});

    return Right(
      AnalyticsData(
        categoryWiseExpenses: categoryWiseExpenses as Map<String, double>,
        topCategories: topCategories as List<CategoryExpense>,
        expenseTrends: expenseTrends as Map<String, dynamic>,
        incomeVsExpense: incomeVsExpense as Map<String, dynamic>,
        startDate: params.startDate,
        endDate: params.endDate,
      ),
    );
  }
}

class GetCategoryWiseExpenses
    implements UseCase<Map<String, double>, DateRangeParams> {
  final AnalyticsRepository repository;

  GetCategoryWiseExpenses(this.repository);

  @override
  Future<Either<Failure, Map<String, double>>> call(DateRangeParams params) {
    return repository.getCategoryWiseExpenses(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetMonthlyExpenses implements UseCase<Map<String, double>, YearParams> {
  final AnalyticsRepository repository;

  GetMonthlyExpenses(this.repository);

  @override
  Future<Either<Failure, Map<String, double>>> call(YearParams params) {
    return repository.getMonthlyExpenses(params.year);
  }
}

class GetIncomeVsExpense
    implements UseCase<Map<String, dynamic>, DateRangeParams> {
  final AnalyticsRepository repository;

  GetIncomeVsExpense(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(DateRangeParams params) {
    return repository.getIncomeVsExpense(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

// Params
class GetAnalyticsParams extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final int topCategoriesLimit;

  const GetAnalyticsParams({
    this.startDate,
    this.endDate,
    this.topCategoriesLimit = 5,
  });

  factory GetAnalyticsParams.thisMonth() {
    final now = DateTime.now();
    return GetAnalyticsParams(
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0, 23, 59, 59),
    );
  }

  factory GetAnalyticsParams.thisYear() {
    final now = DateTime.now();
    return GetAnalyticsParams(
      startDate: DateTime(now.year, 1, 1),
      endDate: DateTime(now.year, 12, 31, 23, 59, 59),
    );
  }

  @override
  List<Object?> get props => [startDate, endDate, topCategoriesLimit];
}

class DateRangeParams extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateRangeParams({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class YearParams extends Equatable {
  final int year;

  const YearParams({required this.year});

  factory YearParams.current() {
    return YearParams(year: DateTime.now().year);
  }

  @override
  List<Object?> get props => [year];
}

// Result data class
class AnalyticsData extends Equatable {
  final Map<String, double> categoryWiseExpenses;
  final List<CategoryExpense> topCategories;
  final Map<String, dynamic> expenseTrends;
  final Map<String, dynamic> incomeVsExpense;
  final DateTime? startDate;
  final DateTime? endDate;

  const AnalyticsData({
    required this.categoryWiseExpenses,
    required this.topCategories,
    required this.expenseTrends,
    required this.incomeVsExpense,
    this.startDate,
    this.endDate,
  });

  double get totalExpense => expenseTrends['totalExpense'] as double? ?? 0.0;

  double get totalIncome => incomeVsExpense['totalIncome'] as double? ?? 0.0;

  double get balance => incomeVsExpense['balance'] as double? ?? 0.0;

  double get savingsRate => incomeVsExpense['savingsRate'] as double? ?? 0.0;

  @override
  List<Object?> get props => [
    categoryWiseExpenses,
    topCategories,
    expenseTrends,
    incomeVsExpense,
    startDate,
    endDate,
  ];
}

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
