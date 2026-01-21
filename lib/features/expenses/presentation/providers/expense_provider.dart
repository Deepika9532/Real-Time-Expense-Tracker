import 'package:flutter/material.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/delete_expense.dart';
import '../../domain/usecases/get_expenses.dart';
import '../../domain/usecases/update_expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final GetExpenses getExpenses;
  final AddExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  ExpenseProvider({
    required this.getExpenses,
    required this.addExpense,
    required this.updateExpense,
    required this.deleteExpense,
  });

  List<ExpenseEntity> expenses = [];

  Future<void> loadExpenses() async {
    expenses = await getExpenses();
    notifyListeners();
  }

  Future<void> add(ExpenseEntity expense) async {
    await addExpense(expense);
    await loadExpenses();
  }

  Future<void> update(ExpenseEntity expense) async {
    await updateExpense(expense);
    await loadExpenses();
  }

  Future<void> delete(String id) async {
    await deleteExpense(id);
    await loadExpenses();
  }
}
