// lib/features/expenses/data/data_sources/expense_local_data_source.dart

import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> addExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
  Future<List<ExpenseModel>> getExpenses();
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final List<ExpenseModel> _expenses = [];

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    _expenses.add(expense);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((e) => e.id == id);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    return _expenses;
  }
}
