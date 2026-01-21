import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class GetExpenses implements UseCase<List<Expense>, GetExpensesParams> {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(GetExpensesParams params) async {
    return await repository.getExpenses(
      startDate: params.startDate,
      endDate: params.endDate,
      categoryId: params.categoryId,
      type: params.type,
    );
  }
}

class GetExpensesParams extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? categoryId;
  final ExpenseType? type;

  const GetExpensesParams({
    this.startDate,
    this.endDate,
    this.categoryId,
    this.type,
  });

  /// Get expenses for today
  factory GetExpensesParams.today() {
    final now = DateTime.now();
    return GetExpensesParams(
      startDate: DateTime(now.year, now.month, now.day),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
  }

  /// Get expenses for this week
  factory GetExpensesParams.thisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return GetExpensesParams(
      startDate: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      endDate: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
  }

  /// Get expenses for this month
  factory GetExpensesParams.thisMonth() {
    final now = DateTime.now();
    return GetExpensesParams(
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0, 23, 59, 59),
    );
  }

  /// Get expenses for this year
  factory GetExpensesParams.thisYear() {
    final now = DateTime.now();
    return GetExpensesParams(
      startDate: DateTime(now.year, 1, 1),
      endDate: DateTime(now.year, 12, 31, 23, 59, 59),
    );
  }

  /// Get expenses for a specific month
  factory GetExpensesParams.forMonth(int year, int month) {
    return GetExpensesParams(
      startDate: DateTime(year, month, 1),
      endDate: DateTime(year, month + 1, 0, 23, 59, 59),
    );
  }

  /// Get expenses for a specific category
  factory GetExpensesParams.forCategory(String categoryId) {
    return GetExpensesParams(categoryId: categoryId);
  }

  /// Get only expenses (not income)
  factory GetExpensesParams.onlyExpenses() {
    return const GetExpensesParams(type: ExpenseType.expense);
  }

  /// Get only income
  factory GetExpensesParams.onlyIncome() {
    return const GetExpensesParams(type: ExpenseType.income);
  }

  @override
  List<Object?> get props => [startDate, endDate, categoryId, type];
}
