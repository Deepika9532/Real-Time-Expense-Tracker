import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';

enum ExpenseStatus { initial, loading, success, error }

class ExpenseProvider extends ChangeNotifier {
  final ExpenseRepository _repository;

  ExpenseProvider({required ExpenseRepository repository})
      : _repository = repository;

  // State
  ExpenseStatus _status = ExpenseStatus.initial;
  List<Expense> _expenses = [];
  Expense? _selectedExpense;
  Failure? _failure;
  String? _errorMessage;

  // Filters
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategoryId;
  ExpenseType? _selectedType;
  String _searchQuery = '';

  // Pagination
  bool _hasMore = true;

  // Getters
  ExpenseStatus get status => _status;
  List<Expense> get expenses => _expenses;
  Expense? get selectedExpense => _selectedExpense;
  Failure? get failure => _failure;
  String? get errorMessage => _errorMessage;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? get selectedCategoryId => _selectedCategoryId;
  ExpenseType? get selectedType => _selectedType;
  String get searchQuery => _searchQuery;
  bool get hasMore => _hasMore;
  bool get isLoading => _status == ExpenseStatus.loading;
  bool get hasError => _status == ExpenseStatus.error;

  // Computed properties
  double get totalExpenses => _expenses
      .where((e) => e.type == ExpenseType.expense)
      .fold(0, (sum, expense) => sum + expense.amount);

  double get totalIncome => _expenses
      .where((e) => e.type == ExpenseType.income)
      .fold(0, (sum, expense) => sum + expense.amount);

  double get balance => totalIncome - totalExpenses;

  List<Expense> get filteredExpenses {
    var filtered = List<Expense>.from(_expenses);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (e) =>
                e.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                (e.description?.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ??
                    false),
          )
          .toList();
    }

    if (_selectedCategoryId != null) {
      filtered =
          filtered.where((e) => e.categoryId == _selectedCategoryId).toList();
    }

    if (_selectedType != null) {
      filtered = filtered.where((e) => e.type == _selectedType).toList();
    }

    if (_startDate != null) {
      filtered = filtered
          .where(
            (e) =>
                e.date.isAfter(_startDate!) ||
                e.date.isAtSameMomentAs(_startDate!),
          )
          .toList();
    }

    if (_endDate != null) {
      filtered = filtered
          .where(
            (e) =>
                e.date.isBefore(_endDate!) ||
                e.date.isAtSameMomentAs(_endDate!),
          )
          .toList();
    }

    return filtered;
  }

  // Load expenses
  Future<void> loadExpenses({bool refresh = false}) async {
    if (refresh) {
      _hasMore = true;
      _expenses.clear();
    }

    _setStatus(ExpenseStatus.loading);

    final result = await _repository.getExpenses(
      startDate: _startDate,
      endDate: _endDate,
      categoryId: _selectedCategoryId,
      type: _selectedType,
    );

    result.fold((failure) => _handleFailure(failure), (expenses) {
      if (refresh) {
        _expenses = expenses;
      } else {
        _expenses.addAll(expenses);
      }
      _hasMore = expenses.length >= 20; // Assuming page size is 20
      _setStatus(ExpenseStatus.success);
    });
  }

  // Load more expenses (pagination)
  Future<void> loadMoreExpenses() async {
    if (!_hasMore || _status == ExpenseStatus.loading) return;

    await loadExpenses();
  }

  // Get expense by ID
  Future<void> getExpenseById(String id) async {
    _setStatus(ExpenseStatus.loading);

    final result = await _repository.getExpenseById(id);

    result.fold((failure) => _handleFailure(failure), (expense) {
      _selectedExpense = expense;
      _setStatus(ExpenseStatus.success);
    });
  }

  // Create expense
  Future<bool> createExpense(Expense expense) async {
    _setStatus(ExpenseStatus.loading);

    final result = await _repository.createExpense(expense);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (createdExpense) {
        _expenses.insert(0, createdExpense);
        _setStatus(ExpenseStatus.success);
        return true;
      },
    );
  }

  // Update expense
  Future<bool> updateExpense(Expense expense) async {
    _setStatus(ExpenseStatus.loading);

    final result = await _repository.updateExpense(expense);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        final index = _expenses.indexWhere((e) => e.id == expense.id);
        if (index != -1) {
          _expenses[index] = expense;
        }
        if (_selectedExpense?.id == expense.id) {
          _selectedExpense = expense;
        }
        _setStatus(ExpenseStatus.success);
        return true;
      },
    );
  }

  // Delete expense
  Future<bool> deleteExpense(String id) async {
    _setStatus(ExpenseStatus.loading);

    final result = await _repository.deleteExpense(id);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _expenses.removeWhere((e) => e.id == id);
        if (_selectedExpense?.id == id) {
          _selectedExpense = null;
        }
        _setStatus(ExpenseStatus.success);
        return true;
      },
    );
  }

  // Search expenses
  Future<void> searchExpenses(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      await loadExpenses(refresh: true);
      return;
    }

    _setStatus(ExpenseStatus.loading);

    final result = await _repository.searchExpenses(query);

    result.fold((failure) => _handleFailure(failure), (expenses) {
      _expenses = expenses;
      _setStatus(ExpenseStatus.success);
    });
  }

  // Set filters
  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    loadExpenses(refresh: true);
  }

  void setCategoryFilter(String? categoryId) {
    _selectedCategoryId = categoryId;
    loadExpenses(refresh: true);
  }

  void setTypeFilter(ExpenseType? type) {
    _selectedType = type;
    loadExpenses(refresh: true);
  }

  void clearFilters() {
    _startDate = null;
    _endDate = null;
    _selectedCategoryId = null;
    _selectedType = null;
    _searchQuery = '';
    loadExpenses(refresh: true);
  }

  // Get expenses by date range
  List<Expense> getExpensesByDateRange(DateTime start, DateTime end) {
    return _expenses
        .where(
          (e) =>
              (e.date.isAfter(start) || e.date.isAtSameMomentAs(start)) &&
              (e.date.isBefore(end) || e.date.isAtSameMomentAs(end)),
        )
        .toList();
  }

  // Get expenses by category
  List<Expense> getExpensesByCategory(String categoryId) {
    return _expenses.where((e) => e.categoryId == categoryId).toList();
  }

  // Get total by category
  double getTotalByCategory(String categoryId) {
    return _expenses
        .where((e) => e.categoryId == categoryId)
        .fold(0, (sum, expense) => sum + expense.amount);
  }

  // Get expenses by type
  List<Expense> getExpensesByType(ExpenseType type) {
    return _expenses.where((e) => e.type == type).toList();
  }

  // Clear selected expense
  void clearSelectedExpense() {
    _selectedExpense = null;
    notifyListeners();
  }

  // Private methods
  void _setStatus(ExpenseStatus status) {
    _status = status;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _failure = failure;
    _errorMessage = failure.message;
    _setStatus(ExpenseStatus.error);
  }

  // Clear error
  void clearError() {
    _failure = null;
    _errorMessage = null;
    if (_status == ExpenseStatus.error) {
      _setStatus(ExpenseStatus.initial);
    }
  }
}
