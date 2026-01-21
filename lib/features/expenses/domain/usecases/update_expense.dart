import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(ExpenseEntity expense) {
    return repository.updateExpense(expense);
  }
}
