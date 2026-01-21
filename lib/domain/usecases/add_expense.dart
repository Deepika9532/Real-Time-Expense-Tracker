import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/expense.dart';
import '../repositories/expense_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class AddExpense implements UseCase<Expense, AddExpenseParams> {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  @override
  Future<Either<Failure, Expense>> call(AddExpenseParams params) async {
    // Validate expense data
    final validationFailure = _validateExpense(params);
    if (validationFailure != null) {
      return Left(validationFailure);
    }

    // Create expense entity
    final expense = Expense(
      id: params.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: params.title,
      amount: params.amount,
      categoryId: params.categoryId,
      date: params.date,
      description: params.description,
      receipt: params.receipt,
      type: params.type,
      userId: params.userId,
      paymentMethod: params.paymentMethod,
      metadata: params.metadata,
      isSynced: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await repository.createExpense(expense);
  }

  ValidationFailure? _validateExpense(AddExpenseParams params) {
    final errors = <String, List<String>>{};

    // Validate title
    if (params.title.trim().isEmpty) {
      errors['title'] = ['Title is required'];
    } else if (params.title.length > 100) {
      errors['title'] = ['Title must be less than 100 characters'];
    }

    // Validate amount
    if (params.amount <= 0) {
      errors['amount'] = ['Amount must be greater than 0'];
    } else if (params.amount > 999999999) {
      errors['amount'] = ['Amount is too large'];
    }

    // Validate category
    if (params.categoryId.trim().isEmpty) {
      errors['categoryId'] = ['Category is required'];
    }

    // Validate date
    if (params.date.isAfter(DateTime.now())) {
      errors['date'] = ['Date cannot be in the future'];
    }

    // Validate description length
    if (params.description != null && params.description!.length > 500) {
      errors['description'] = ['Description must be less than 500 characters'];
    }

    if (errors.isNotEmpty) {
      return ValidationFailure(message: 'Invalid expense data', errors: errors);
    }

    return null;
  }
}

class AddExpenseParams extends Equatable {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? description;
  final String? receipt;
  final ExpenseType type;
  final String? userId;
  final String? paymentMethod;
  final Map<String, dynamic>? metadata;

  const AddExpenseParams({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.description,
    this.receipt,
    this.type = ExpenseType.expense,
    this.userId,
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
    userId,
    paymentMethod,
    metadata,
  ];
}
