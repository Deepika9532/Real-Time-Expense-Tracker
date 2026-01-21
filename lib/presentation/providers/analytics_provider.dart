import 'package:flutter/foundation.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/category.dart' as domain;
import '../../domain/entities/expense.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/expense_repository.dart';

enum AnalyticsStatus { initial, loading, success, error }

enum ChartType { pie, bar, line, donut }

enum TimePeriod { daily, weekly, monthly, yearly, custom }

class AnalyticsProvider extends ChangeNotifier {
  final ExpenseRepository _expenseRepository;
  final CategoryRepository _categoryRepository;

  AnalyticsProvider({
    required ExpenseRepository expenseRepository,
    required CategoryRepository categoryRepository,
  })  : _expenseRepository = expenseRepository,
        _categoryRepository = categoryRepository;

  // State
  AnalyticsStatus _status = AnalyticsStatus.initial;
  List<Expense> _expenses = [];
  List<domain.Category> _categories = [];
  Failure? _failure;
  String? _errorMessage;

  // Filters
  TimePeriod _selectedPeriod = TimePeriod.monthly;
  DateTime? _startDate;
  DateTime? _endDate;
  ExpenseType _selectedType = ExpenseType.expense;

  // Getters
  AnalyticsStatus get status => _status;
  List<Expense> get expenses => _expenses;
  List<domain.Category> get categories => _categories;
  Failure? get failure => _failure;
  String? get errorMessage => _errorMessage;
  TimePeriod get selectedPeriod => _selectedPeriod;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  ExpenseType get selectedType => _selectedType;
  bool get isLoading => _status == AnalyticsStatus.loading;
  bool get hasError => _status == AnalyticsStatus.error;

  // Computed properties - Summary Statistics
  double get totalExpenses => _expenses
      .where((e) => e.type == ExpenseType.expense)
      .fold(0.0, (sum, expense) => sum + expense.amount);

  double get totalIncome => _expenses
      .where((e) => e.type == ExpenseType.income)
      .fold(0.0, (sum, expense) => sum + expense.amount);

  double get balance => totalIncome - totalExpenses;

  double get averageExpense {
    final expenseList = _expenses.where((e) => e.type == ExpenseType.expense);
    if (expenseList.isEmpty) return 0.0;
    return totalExpenses / expenseList.length;
  }

  double get averageIncome {
    final incomeList = _expenses.where((e) => e.type == ExpenseType.income);
    if (incomeList.isEmpty) return 0.0;
    return totalIncome / incomeList.length;
  }

  int get transactionCount => _expenses.length;

  // Category-based analytics
  Map<String, double> get expensesByCategory {
    final Map<String, double> categoryTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.expense) {
        categoryTotals[expense.categoryId] =
            (categoryTotals[expense.categoryId] ?? 0.0) + expense.amount;
      }
    }

    return categoryTotals;
  }

  Map<String, double> get incomeByCategory {
    final Map<String, double> categoryTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.income) {
        categoryTotals[expense.categoryId] =
            (categoryTotals[expense.categoryId] ?? 0.0) + expense.amount;
      }
    }

    return categoryTotals;
  }

  List<Map<String, dynamic>> get topExpenseCategories {
    final categoryTotals = expensesByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return categoryTotals.take(5).map((entry) {
      final category = _categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => domain.Category(
          id: entry.key,
          name: 'Unknown',
          icon: 'help_outline',
          color: 0xFF9E9E9E,
          type: domain.CategoryType.expense,
        ),
      );

      return {
        'category': category,
        'amount': entry.value,
        'percentage': (entry.value / totalExpenses) * 100,
      };
    }).toList();
  }

  // Time-based analytics
  Map<DateTime, double> get dailyExpenses {
    final Map<DateTime, double> dailyTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.expense) {
        final date = DateTime(
          expense.date.year,
          expense.date.month,
          expense.date.day,
        );
        dailyTotals[date] = (dailyTotals[date] ?? 0.0) + expense.amount;
      }
    }

    return dailyTotals;
  }

  Map<DateTime, double> get monthlyExpenses {
    final Map<DateTime, double> monthlyTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.expense) {
        final date = DateTime(expense.date.year, expense.date.month);
        monthlyTotals[date] = (monthlyTotals[date] ?? 0.0) + expense.amount;
      }
    }

    return monthlyTotals;
  }

  Map<DateTime, double> get yearlyExpenses {
    final Map<DateTime, double> yearlyTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.expense) {
        final date = DateTime(expense.date.year);
        yearlyTotals[date] = (yearlyTotals[date] ?? 0.0) + expense.amount;
      }
    }

    return yearlyTotals;
  }

  // Trend analysis
  Map<String, dynamic> get expenseTrend {
    if (_expenses.isEmpty) {
      return {'trend': 'stable', 'percentage': 0.0};
    }

    final sortedExpenses = List<Expense>.from(_expenses)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Split into two halves
    final midPoint = sortedExpenses.length ~/ 2;
    final firstHalf = sortedExpenses.sublist(0, midPoint);
    final secondHalf = sortedExpenses.sublist(midPoint);

    final firstHalfTotal = firstHalf
        .where((e) => e.type == ExpenseType.expense)
        .fold(0.0, (sum, e) => sum + e.amount);
    final secondHalfTotal = secondHalf
        .where((e) => e.type == ExpenseType.expense)
        .fold(0.0, (sum, e) => sum + e.amount);

    if (firstHalfTotal == 0) {
      return {'trend': 'increasing', 'percentage': 100.0};
    }

    final percentageChange =
        ((secondHalfTotal - firstHalfTotal) / firstHalfTotal) * 100;

    String trend;
    if (percentageChange > 5) {
      trend = 'increasing';
    } else if (percentageChange < -5) {
      trend = 'decreasing';
    } else {
      trend = 'stable';
    }

    return {'trend': trend, 'percentage': percentageChange.abs()};
  }

  // Load analytics data
  Future<void> loadAnalytics({bool refresh = false}) async {
    _setStatus(AnalyticsStatus.loading);

    // Set date range based on selected period
    _setDateRangeForPeriod();

    // Load expenses
    final expensesResult = await _expenseRepository.getExpenses(
      startDate: _startDate,
      endDate: _endDate,
    );

    // Load categories
    final categoriesResult = await _categoryRepository.getCategories();

    await expensesResult.fold(
      (failure) async {
        _handleFailure(failure);
      },
      (expenses) async {
        _expenses = expenses;

        await categoriesResult.fold(
          (failure) {
            _handleFailure(failure);
          },
          (categories) {
            _categories = categories;
            _setStatus(AnalyticsStatus.success);
          },
        );
      },
    );
  }

  // Set time period
  void setTimePeriod(TimePeriod period) {
    _selectedPeriod = period;
    loadAnalytics();
  }

  // Set custom date range
  void setCustomDateRange(DateTime start, DateTime end) {
    _selectedPeriod = TimePeriod.custom;
    _startDate = start;
    _endDate = end;
    loadAnalytics();
  }

  // Set expense type filter
  void setExpenseType(ExpenseType type) {
    _selectedType = type;
    notifyListeners();
  }

  // Get chart data for category distribution
  List<Map<String, dynamic>> getCategoryChartData() {
    final categoryData = _selectedType == ExpenseType.expense
        ? expensesByCategory
        : incomeByCategory;

    return categoryData.entries.map((entry) {
      final category = _categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => domain.Category(
          id: entry.key,
          name: 'Unknown',
          icon: 'help_outline',
          color: 0xFF9E9E9E,
          type: _selectedType == ExpenseType.expense
              ? domain.CategoryType.expense
              : domain.CategoryType.income,
        ),
      );

      return {
        'category': category.name,
        'amount': entry.value,
        'color': category.color,
        'icon': category.icon,
      };
    }).toList()
      ..sort(
        (a, b) => (b['amount'] as double).compareTo(a['amount'] as double),
      );
  }

  // Get time series chart data
  List<Map<String, dynamic>> getTimeSeriesChartData() {
    Map<DateTime, double> timeData;

    switch (_selectedPeriod) {
      case TimePeriod.daily:
        timeData = dailyExpenses;
        break;
      case TimePeriod.monthly:
        timeData = monthlyExpenses;
        break;
      case TimePeriod.yearly:
        timeData = yearlyExpenses;
        break;
      default:
        timeData = dailyExpenses;
    }

    return timeData.entries
        .map((entry) => {'date': entry.key, 'amount': entry.value})
        .toList()
      ..sort(
        (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
      );
  }

  // Get expense comparison data (current vs previous period)
  Map<String, dynamic> getComparisonData() {
    final currentPeriodTotal = totalExpenses;
    final previousPeriodExpenses = _getPreviousPeriodExpenses();

    final difference = currentPeriodTotal - previousPeriodExpenses;
    final percentageChange = previousPeriodExpenses == 0
        ? 100.0
        : (difference / previousPeriodExpenses) * 100;

    return {
      'current': currentPeriodTotal,
      'previous': previousPeriodExpenses,
      'difference': difference,
      'percentageChange': percentageChange,
      'isIncreased': difference > 0,
    };
  }

  // Get spending by payment method
  Map<String, double> getSpendingByPaymentMethod() {
    final Map<String, double> paymentMethodTotals = {};

    for (final expense in _expenses) {
      if (expense.type == ExpenseType.expense &&
          expense.paymentMethod != null) {
        paymentMethodTotals[expense.paymentMethod!] =
            (paymentMethodTotals[expense.paymentMethod!] ?? 0.0) +
                expense.amount;
      }
    }

    return paymentMethodTotals;
  }

  // Get budget vs actual spending
  Map<String, dynamic> getBudgetAnalysis(Map<String, double> categoryBudgets) {
    final Map<String, dynamic> analysis = {};

    for (final entry in categoryBudgets.entries) {
      final categoryId = entry.key;
      final budgetAmount = entry.value;
      final actualAmount = expensesByCategory[categoryId] ?? 0.0;
      final remaining = budgetAmount - actualAmount;
      final percentageUsed =
          budgetAmount == 0 ? 0.0 : (actualAmount / budgetAmount) * 100;

      analysis[categoryId] = {
        'budget': budgetAmount,
        'actual': actualAmount,
        'remaining': remaining,
        'percentageUsed': percentageUsed,
        'isOverBudget': actualAmount > budgetAmount,
      };
    }

    return analysis;
  }

  // Private helper methods
  void _setDateRangeForPeriod() {
    final now = DateTime.now();

    switch (_selectedPeriod) {
      case TimePeriod.daily:
        _startDate = DateTime(now.year, now.month, now.day);
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case TimePeriod.weekly:
        final weekday = now.weekday;
        _startDate = now.subtract(Duration(days: weekday - 1));
        _endDate = now.add(Duration(days: 7 - weekday));
        break;
      case TimePeriod.monthly:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
      case TimePeriod.yearly:
        _startDate = DateTime(now.year, 1, 1);
        _endDate = DateTime(now.year, 12, 31, 23, 59, 59);
        break;
      case TimePeriod.custom:
        // Keep existing custom dates
        break;
    }
  }

  double _getPreviousPeriodExpenses() {
    if (_startDate == null || _endDate == null) return 0.0;

    final duration = _endDate!.difference(_startDate!);
    final previousStart = _startDate!.subtract(duration);
    final previousEnd = _endDate!.subtract(duration);

    return _expenses
        .where(
          (e) =>
              e.type == ExpenseType.expense &&
              e.date.isAfter(previousStart) &&
              e.date.isBefore(previousEnd),
        )
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  void _setStatus(AnalyticsStatus status) {
    _status = status;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _failure = failure;
    _errorMessage = failure.message;
    _setStatus(AnalyticsStatus.error);
  }

  // Clear error
  void clearError() {
    _failure = null;
    _errorMessage = null;
    if (_status == AnalyticsStatus.error) {
      _setStatus(AnalyticsStatus.initial);
    }
  }
}
