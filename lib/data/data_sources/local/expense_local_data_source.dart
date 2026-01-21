import '../../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  });
  Future<ExpenseModel> getExpenseById(String id);
  Future<ExpenseModel> createExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
  Future<List<ExpenseModel>> searchExpenses(String query);
  Future<List<ExpenseModel>> getUnsyncedExpenses();
  Future<void> clearAllExpenses();
}
