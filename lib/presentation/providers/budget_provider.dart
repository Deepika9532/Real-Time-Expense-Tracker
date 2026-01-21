import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/budget.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/budget_repository.dart';
import '../../domain/repositories/expense_repository.dart';

enum BudgetStatus { initial, loading, success, error }

class BudgetProvider extends ChangeNotifier {
  final BudgetRepository _budgetRepository;
  final ExpenseRepository _expenseRepository;

  BudgetProvider({
    required BudgetRepository budgetRepository,
    required ExpenseRepository expenseRepository,
  })  : _budgetRepository = budgetRepository,
        _expenseRepository = expenseRepository {
    loadBudgets();
  }

  // State
  BudgetStatus _status = BudgetStatus.initial;
  List<Budget> _budgets = [];
  Budget? _selectedBudget;
  Failure? _failure;
  String? _errorMessage;
  final Map<String, double> _budgetSpending = {};

  // Filters
  bool _showInactiveBudgets = false;
  BudgetPeriod? _selectedPeriod;

  // Getters
  BudgetStatus get status => _status;
  List<Budget> get budgets => _budgets;
  Budget? get selectedBudget => _selectedBudget;
  Failure? get failure => _failure;
  String? get errorMessage => _errorMessage;
  Map<String, double> get budgetSpending => _budgetSpending;
  bool get showInactiveBudgets => _showInactiveBudgets;
  BudgetPeriod? get selectedPeriod => _selectedPeriod;
  bool get isLoading => _status == BudgetStatus.loading;
  bool get hasError => _status == BudgetStatus.error;

  // Computed properties
  List<Budget> get activeBudgets => _budgets.where((b) => b.isActive).toList();

  List<Budget> get filteredBudgets {
    var filtered = _showInactiveBudgets ? _budgets : activeBudgets;

    if (_selectedPeriod != null) {
      filtered = filtered.where((b) => b.period == _selectedPeriod).toList();
    }

    return filtered;
  }

  double get totalBudgetAmount =>
      activeBudgets.fold(0.0, (sum, budget) => sum + budget.amount);

  double get totalBudgetSpent =>
      activeBudgets.fold(0.0, (sum, budget) => sum + (budget.spent));

  double get totalBudgetRemaining => totalBudgetAmount - totalBudgetSpent;

  double get overallBudgetProgress {
    if (totalBudgetAmount == 0) return 0.0;
    return (totalBudgetSpent / totalBudgetAmount).clamp(0.0, 1.0);
  }

  List<Budget> get overdraftBudgets =>
      activeBudgets.where((b) => (b.spent) > b.amount).toList();

  List<Budget> get nearLimitBudgets => activeBudgets
      .where(
        (b) =>
            (b.spent) >= b.amount * (b.warningThreshold ?? 0.8) &&
            (b.spent) <= b.amount,
      )
      .toList();

  // Load budgets
  Future<void> loadBudgets({bool refresh = false}) async {
    if (refresh || _budgets.isEmpty) {
      _setStatus(BudgetStatus.loading);
    }

    final result = await _budgetRepository.getBudgets();

    result.fold((failure) => _handleFailure(failure), (budgets) async {
      _budgets = budgets;
      await _loadBudgetSpending();
      _setStatus(BudgetStatus.success);
    });
  }

  // Load spending for each budget
  Future<void> _loadBudgetSpending() async {
    for (final budget in _budgets) {
      final spending = await _calculateBudgetSpending(budget);
      _budgetSpending[budget.id] = spending;

      // Update budget with current spending
      final index = _budgets.indexWhere((b) => b.id == budget.id);
      if (index != -1) {
        _budgets[index] = budget.copyWith(spent: spending);
      }
    }
  }

  // Calculate spending for a budget
  Future<double> _calculateBudgetSpending(Budget budget) async {
    final result = await _expenseRepository.getExpenses(
      startDate: budget.startDate,
      endDate: budget.endDate,
      categoryId: budget.categoryId,
    );

    return result.fold(
      (failure) => 0.0,
      (expenses) {
        double total = 0.0;
        for (final expense in expenses) {
          if (expense.type == ExpenseType.expense) {
            total += expense.amount;
          }
        }
        return total;
      },
    );
  }

  // Get budget by ID
  Future<void> getBudgetById(String id) async {
    _setStatus(BudgetStatus.loading);

    final result = await _budgetRepository.getBudgetById(id);

    result.fold((failure) => _handleFailure(failure), (budget) async {
      _selectedBudget = budget;
      final spending = await _calculateBudgetSpending(budget);
      _selectedBudget = budget.copyWith(spent: spending);
      _setStatus(BudgetStatus.success);
    });
  }

  // Create budget
  Future<bool> createBudget(Budget budget) async {
    _setStatus(BudgetStatus.loading);

    final result = await _budgetRepository.createBudget(budget);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (createdBudget) async {
        _budgets.add(createdBudget);
        final spending = await _calculateBudgetSpending(createdBudget);
        _budgetSpending[createdBudget.id] = spending;
        _setStatus(BudgetStatus.success);
        return true;
      },
    );
  }

  // Update budget
  Future<bool> updateBudget(Budget budget) async {
    _setStatus(BudgetStatus.loading);

    final result = await _budgetRepository.updateBudget(budget);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) async {
        final index = _budgets.indexWhere((b) => b.id == budget.id);
        if (index != -1) {
          final spending = await _calculateBudgetSpending(budget);
          _budgets[index] = budget.copyWith(spent: spending);
          _budgetSpending[budget.id] = spending;
        }
        if (_selectedBudget?.id == budget.id) {
          _selectedBudget = budget;
        }
        _setStatus(BudgetStatus.success);
        return true;
      },
    );
  }

  // Delete budget
  Future<bool> deleteBudget(String id) async {
    _setStatus(BudgetStatus.loading);

    final result = await _budgetRepository.deleteBudget(id);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _budgets.removeWhere((b) => b.id == id);
        _budgetSpending.remove(id);
        if (_selectedBudget?.id == id) {
          _selectedBudget = null;
        }
        _setStatus(BudgetStatus.success);
        return true;
      },
    );
  }

  // Toggle budget status
  Future<bool> toggleBudgetStatus(String id) async {
    final budget = _budgets.firstWhere((b) => b.id == id);
    final updatedBudget = budget.copyWith(isActive: !budget.isActive);
    return await updateBudget(updatedBudget);
  }

  // Get budget progress
  double getBudgetProgress(String budgetId) {
    final budget = _budgets.firstWhere((b) => b.id == budgetId);
    final spent = _budgetSpending[budgetId] ?? 0.0;

    if (budget.amount == 0) return 0.0;
    return (spent / budget.amount).clamp(0.0, 1.0);
  }

  // Get budget remaining amount
  double getBudgetRemaining(String budgetId) {
    final budget = _budgets.firstWhere((b) => b.id == budgetId);
    final spent = _budgetSpending[budgetId] ?? 0.0;
    return (budget.amount - spent).clamp(0.0, double.infinity);
  }

  // Check if budget is exceeded
  bool isBudgetExceeded(String budgetId) {
    final budget = _budgets.firstWhere((b) => b.id == budgetId);
    final spent = _budgetSpending[budgetId] ?? 0.0;
    return spent > budget.amount;
  }

  // Check if budget is near limit
  bool isBudgetNearLimit(String budgetId) {
    final budget = _budgets.firstWhere((b) => b.id == budgetId);
    final spent = _budgetSpending[budgetId] ?? 0.0;
    final threshold = budget.warningThreshold ?? 0.8;
    return spent >= (budget.amount * threshold) && spent <= budget.amount;
  }

  // Get budget status
  String getBudgetStatus(String budgetId) {
    if (isBudgetExceeded(budgetId)) return 'exceeded';
    if (isBudgetNearLimit(budgetId)) return 'warning';
    return 'safe';
  }

  // Get budgets by period
  List<Budget> getBudgetsByPeriod(BudgetPeriod period) {
    return activeBudgets.where((b) => b.period == period).toList();
  }

  // Get budgets by category
  List<Budget> getBudgetsByCategory(String categoryId) {
    return activeBudgets.where((b) => b.categoryId == categoryId).toList();
  }

  // Get active budgets for current period
  List<Budget> getActiveBudgetsForCurrentPeriod() {
    final now = DateTime.now();
    return activeBudgets
        .where((b) => b.startDate.isBefore(now) && b.endDate.isAfter(now))
        .toList();
  }

  // Renew recurring budgets
  Future<void> renewRecurringBudgets() async {
    final now = DateTime.now();
    final expiredRecurringBudgets = activeBudgets
        .where((b) => b.isRecurring && b.endDate.isBefore(now))
        .toList();

    for (final budget in expiredRecurringBudgets) {
      final duration = budget.endDate.difference(budget.startDate);
      final newStartDate = budget.endDate.add(const Duration(days: 1));
      final newEndDate = newStartDate.add(duration);

      final renewedBudget = budget.copyWith(
        startDate: newStartDate,
        endDate: newEndDate,
        spent: 0.0,
      );

      await createBudget(renewedBudget);
    }
  }

  // Set period filter
  void setPeriodFilter(BudgetPeriod? period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  // Toggle show inactive budgets
  void toggleShowInactiveBudgets() {
    _showInactiveBudgets = !_showInactiveBudgets;
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedPeriod = null;
    _showInactiveBudgets = false;
    notifyListeners();
  }

  // Select budget
  void selectBudget(Budget budget) {
    _selectedBudget = budget;
    notifyListeners();
  }

  // Clear selected budget
  void clearSelectedBudget() {
    _selectedBudget = null;
    notifyListeners();
  }

  // Validate budget
  String? validateBudget(Budget budget) {
    if (budget.name.trim().isEmpty) {
      return 'Budget name is required';
    }

    if (budget.amount <= 0) {
      return 'Budget amount must be greater than zero';
    }

    if (budget.endDate.isBefore(budget.startDate)) {
      return 'End date must be after start date';
    }

    return null;
  }

  // Get budget summary
  Map<String, dynamic> getBudgetSummary() {
    return {
      'totalBudgets': _budgets.length,
      'activeBudgets': activeBudgets.length,
      'totalAmount': totalBudgetAmount,
      'totalSpent': totalBudgetSpent,
      'totalRemaining': totalBudgetRemaining,
      'overallProgress': overallBudgetProgress,
      'overdraftBudgets': overdraftBudgets.length,
      'nearLimitBudgets': nearLimitBudgets.length,
    };
  }

  // Private methods
  void _setStatus(BudgetStatus status) {
    _status = status;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _failure = failure;
    _errorMessage = failure.message;
    _setStatus(BudgetStatus.error);
  }

  // Clear error
  void clearError() {
    _failure = null;
    _errorMessage = null;
    if (_status == BudgetStatus.error) {
      _setStatus(BudgetStatus.initial);
    }
  }
}
