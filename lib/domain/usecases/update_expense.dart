import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/expense.dart';
import '../repositories/expense_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class UpdateExpense implements UseCase<Expense, UpdateExpenseParams> {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  @override
  Future<Either<Failure, Expense>> call(UpdateExpenseParams params) async {
    // Validate expense data
    final validationFailure = _validateExpense(params);
    if (validationFailure != null) {
      return Left(validationFailure);
    }

    // Get existing expense first
    final existingExpenseResult = await repository.getExpenseById(params.id);

    return existingExpenseResult.fold((failure) => Left(failure), (
      existingExpense,
    ) async {
      // Update expense with new data
      final updatedExpense = existingExpense.copyWith(
        title: params.title ?? existingExpense.title,
        amount: params.amount ?? existingExpense.amount,
        categoryId: params.categoryId ?? existingExpense.categoryId,
        date: params.date ?? existingExpense.date,
        description: params.description ?? existingExpense.description,
        receipt: params.receipt ?? existingExpense.receipt,
        type: params.type ?? existingExpense.type,
        paymentMethod: params.paymentMethod ?? existingExpense.paymentMethod,
        metadata: params.metadata ?? existingExpense.metadata,
        updatedAt: DateTime.now(),
        isSynced: false,
      );

      return await repository.updateExpense(updatedExpense);
    });
  }

  ValidationFailure? _validateExpense(UpdateExpenseParams params) {
    final errors = <String, List<String>>{};

    // Validate ID
    if (params.id.trim().isEmpty) {
      errors['id'] = ['Expense ID is required'];
    }

    // Validate title if provided
    if (params.title != null) {
      if (params.title!.trim().isEmpty) {
        errors['title'] = ['Title cannot be empty'];
      } else if (params.title!.length > 100) {
        errors['title'] = ['Title must be less than 100 characters'];
      }
    }

    // Validate amount if provided
    if (params.amount != null) {
      if (params.amount! <= 0) {
        errors['amount'] = ['Amount must be greater than 0'];
      } else if (params.amount! > 999999999) {
        errors['amount'] = ['Amount is too large'];
      }
    }

    // Validate category if provided
    if (params.categoryId != null && params.categoryId!.trim().isEmpty) {
      errors['categoryId'] = ['Category cannot be empty'];
    }

    // Validate date if provided
    if (params.date != null && params.date!.isAfter(DateTime.now())) {
      errors['date'] = ['Date cannot be in the future'];
    }

    // Validate description length if provided
    if (params.description != null && params.description!.length > 500) {
      errors['description'] = ['Description must be less than 500 characters'];
    }

    if (errors.isNotEmpty) {
      return ValidationFailure(message: 'Invalid expense data', errors: errors);
    }

    return null;
  }
}

class UpdateExpenseParams extends Equatable {
  final String id;
  final String? title;
  final double? amount;
  final String? categoryId;
  final DateTime? date;
  final String? description;
  final String? receipt;
  final ExpenseType? type;
  final String? paymentMethod;
  final Map<String, dynamic>? metadata;

  const UpdateExpenseParams({
    required this.id,
    this.title,
    this.amount,
    this.categoryId,
    this.date,
    this.description,
    this.receipt,
    this.type,
    this.paymentMethod,
    this.metadata,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    categoryId,
    date,
    description,
    receipt,
    type,
    paymentMethod,
    metadata,
  ];
}
