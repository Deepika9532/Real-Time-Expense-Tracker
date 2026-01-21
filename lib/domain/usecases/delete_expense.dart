import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/expense_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class DeleteExpense implements UseCase<void, DeleteExpenseParams> {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async {
    // Validate expense ID
    if (params.id.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Expense ID is required'));
    }

    // Check if expense exists before deleting
    if (params.checkExists) {
      final existsResult = await repository.expenseExists(params.id);

      return existsResult.fold((failure) => Left(failure), (exists) async {
        if (!exists) {
          return const Left(NotFoundFailure(message: 'Expense not found'));
        }
        return await repository.deleteExpense(params.id);
      });
    }

    return await repository.deleteExpense(params.id);
  }
}

/// Delete multiple expenses
class DeleteMultipleExpenses
    implements UseCase<void, DeleteMultipleExpensesParams> {
  final ExpenseRepository repository;

  DeleteMultipleExpenses(this.repository);

  @override
  Future<Either<Failure, void>> call(
    DeleteMultipleExpensesParams params,
  ) async {
    // Validate expense IDs
    if (params.ids.isEmpty) {
      return const Left(
        ValidationFailure(message: 'At least one expense ID is required'),
      );
    }

    // Remove duplicates
    final uniqueIds = params.ids.toSet().toList();

    return await repository.deleteMultipleExpenses(uniqueIds);
  }
}

class DeleteExpenseParams extends Equatable {
  final String id;
  final bool checkExists;

  const DeleteExpenseParams({required this.id, this.checkExists = true});

  @override
  List<Object?> get props => [id, checkExists];
}

class DeleteMultipleExpensesParams extends Equatable {
  final List<String> ids;

  const DeleteMultipleExpensesParams({required this.ids});

  @override
  List<Object?> get props => [ids];
}
