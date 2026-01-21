import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import '../data_sources/expense_local_data_source.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource local;

  ExpenseRepositoryImpl(this.local);

  @override
  Future<void> addExpense(ExpenseEntity expense) {
    return local.addExpense(
      ExpenseModel(
        id: expense.id,
        title: expense.title,
        amount: expense.amount,
        category: expense.category,
        date: expense.date,
      ),
    );
  }

  @override
  Future<void> updateExpense(ExpenseEntity expense) {
    return local.updateExpense(
      ExpenseModel(
        id: expense.id,
        title: expense.title,
        amount: expense.amount,
        category: expense.category,
        date: expense.date,
      ),
    );
  }

  @override
  Future<void> deleteExpense(String id) {
    return local.deleteExpense(id);
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() {
    return local.getExpenses();
  }
}
