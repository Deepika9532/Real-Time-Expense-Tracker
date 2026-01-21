import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:real_time_expense_tracker/core/errors/failures.dart';
import 'package:real_time_expense_tracker/domain/entities/expense.dart';
import 'package:real_time_expense_tracker/domain/repositories/expense_repository.dart';
import 'package:real_time_expense_tracker/domain/usecases/add_expense.dart';

import 'add_expense_test.mocks.dart';

@GenerateMocks([ExpenseRepository])
void main() {
  late AddExpense usecase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    usecase = AddExpense(mockExpenseRepository);
  });

  group('AddExpense', () {
    final tExpense = Expense(
      id: '1',
      title: 'Test Expense',
      amount: 100.0,
      categoryId: 'category-1',
      date: DateTime(2024, 1, 15),
      description: 'Test description',
    );

    test('should add expense through the repository', () async {
      // arrange
      when(mockExpenseRepository.addExpense(any))
          .thenAnswer((_) async => Right(tExpense));

      // act
      final result = await usecase(AddExpenseParams(
        title: tExpense.title,
        amount: tExpense.amount,
        categoryId: tExpense.categoryId,
        date: tExpense.date,
        description: tExpense.description,
      ));

      // assert
      expect(result, Right(tExpense));
      verify(mockExpenseRepository.addExpense(tExpense));
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      when(mockExpenseRepository.addExpense(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')));

      final expenseToAdd = Expense(
        id: '1',
        title: 'Test',
        amount: 100.0,
        categoryId: 'category-1',
        date: DateTime.now(),
      );

      // act
      final result = await usecase(AddExpenseParams(
        title: expenseToAdd.title,
        amount: expenseToAdd.amount,
        categoryId: expenseToAdd.categoryId,
        date: expenseToAdd.date,
      ));

      // assert
      expect(result, const Left(ServerFailure(message: 'Server error')));
      verify(mockExpenseRepository.addExpense(expenseToAdd));
    });

    test('should return ValidationFailure for invalid amount', () async {
      // arrange
      final invalidExpense = Expense(
        id: '1',
        title: 'Test',
        amount: -100.0,
        categoryId: 'category-1',
        date: DateTime.now(),
      );

      when(mockExpenseRepository.addExpense(any)).thenAnswer((_) async =>
          const Left(ValidationFailure(message: 'Invalid amount')));

      // act
      final result = await usecase(AddExpenseParams(
        title: invalidExpense.title,
        amount: invalidExpense.amount,
        categoryId: invalidExpense.categoryId,
        date: invalidExpense.date,
      ));

      // assert
      expect(result, const Left(ValidationFailure(message: 'Invalid amount')));
      verify(mockExpenseRepository.addExpense(invalidExpense));
    });

    test('should return ValidationFailure for empty title', () async {
      // arrange
      final emptyTitleExpense = Expense(
        id: '1',
        title: '',
        amount: 100.0,
        categoryId: 'category-1',
        date: DateTime.now(),
      );

      when(mockExpenseRepository.addExpense(any)).thenAnswer((_) async =>
          const Left(ValidationFailure(message: 'Title cannot be empty')));

      // act
      final result = await usecase(AddExpenseParams(
        title: emptyTitleExpense.title,
        amount: emptyTitleExpense.amount,
        categoryId: emptyTitleExpense.categoryId,
        date: emptyTitleExpense.date,
      ));

      // assert
      expect(result,
          const Left(ValidationFailure(message: 'Title cannot be empty')));
      verify(mockExpenseRepository.addExpense(emptyTitleExpense));
    });

    test('should handle duplicate expense', () async {
      // arrange
      final duplicateExpense = Expense(
        id: '1',
        title: 'Test',
        amount: 100.0,
        categoryId: 'category-1',
        date: DateTime.now(),
      );

      when(mockExpenseRepository.addExpense(any)).thenAnswer((_) async =>
          const Left(DuplicateExpenseFailure(message: 'Duplicate expense')));

      // act
      final result = await usecase(AddExpenseParams(
        title: duplicateExpense.title,
        amount: duplicateExpense.amount,
        categoryId: duplicateExpense.categoryId,
        date: duplicateExpense.date,
      ));

      // assert
      expect(result,
          const Left(DuplicateExpenseFailure(message: 'Duplicate expense')));
      verify(mockExpenseRepository.addExpense(duplicateExpense));
    });
  });
}
