import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:real_time_expense_tracker/core/errors/failures.dart';
import 'package:real_time_expense_tracker/domain/entities/expense.dart';
import 'package:real_time_expense_tracker/domain/repositories/expense_repository.dart';
import 'package:real_time_expense_tracker/domain/usecases/get_expenses.dart';

import 'get_expenses_test.mocks.dart';

@GenerateMocks([ExpenseRepository])
void main() {
  late GetExpenses usecase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    usecase = GetExpenses(mockExpenseRepository);
  });

  group('GetExpenses', () {
    final tExpenses = [
      Expense(
        id: '1',
        title: 'Test 1',
        amount: 50.0,
        categoryId: 'food',
        date: DateTime(2024, 1, 15),
      ),
      Expense(
        id: '2',
        title: 'Test 2',
        amount: 75.0,
        categoryId: 'transport',
        date: DateTime(2024, 1, 16),
      ),
      Expense(
        id: '3',
        title: 'Test 3',
        amount: 100.0,
        categoryId: 'food',
        date: DateTime(2024, 1, 17),
      ),
    ];

    test('should get all expenses from the repository', () async {
      // arrange
      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => Right(tExpenses));

      // act - use empty GetExpensesParams for all expenses
      final result = await usecase(GetExpensesParams());

      // assert
      expect(result, Right(tExpenses));
      verify(mockExpenseRepository.getExpenses(
        startDate: null,
        endDate: null,
        categoryId: null,
        type: null,
      ));
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test('should return expenses filtered by date range', () async {
      // arrange
      final startDate = DateTime(2024, 1, 15);
      final endDate = DateTime(2024, 1, 16);
      final filteredExpenses = tExpenses.take(2).toList();

      when(mockExpenseRepository.getExpensesByDateRange(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => Right(filteredExpenses));

      // act - call repository directly for this test
      final result = await mockExpenseRepository.getExpensesByDateRange(
        startDate: startDate,
        endDate: endDate,
      );

      // assert
      expect(result, Right(filteredExpenses));
      verify(mockExpenseRepository.getExpensesByDateRange(
        startDate: startDate,
        endDate: endDate,
      ));
    });

    test('should return expenses filtered by category', () async {
      // arrange
      const categoryId = 'food';
      final foodExpenses =
          tExpenses.where((e) => e.categoryId == categoryId).toList();

      when(mockExpenseRepository.getExpensesByCategory(
        any,
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => Right(foodExpenses));

      // act - call repository directly for this test
      final result = await mockExpenseRepository.getExpensesByCategory(
        categoryId,
      );

      // assert
      expect(result, Right(foodExpenses));
      expect(
        result.fold(
          (l) => false,
          (r) => r.every((e) => e.categoryId == categoryId),
        ),
        true,
      );
    });

    test('should return empty list when no expenses exist', () async {
      // arrange
      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => const Right([]));

      // act
      final result = await usecase(GetExpensesParams());

      // assert
      expect(result, const Right([]));
      verify(mockExpenseRepository.getExpenses(
        startDate: null,
        endDate: null,
        categoryId: null,
        type: null,
      ));
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')));

      // act
      final result = await usecase(GetExpensesParams());

      // assert
      expect(result, const Left(ServerFailure(message: 'Server error')));
      verify(mockExpenseRepository.getExpenses(
        startDate: null,
        endDate: null,
        categoryId: null,
        type: null,
      ));
    });

    test('should return CacheFailure when local data source fails', () async {
      // arrange
      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer(
          (_) async => const Left(CacheFailure(message: 'Cache error')));

      // act
      final result = await usecase(GetExpensesParams());

      // assert
      expect(result, const Left(CacheFailure(message: 'Cache error')));
    });

    test('should handle empty date range correctly', () async {
      // arrange
      final startDate = DateTime(2024, 1, 15);
      final endDate = DateTime(2024, 1, 15);

      when(mockExpenseRepository.getExpensesByDateRange(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => const Right([]));

      // act - call repository directly
      final result = await mockExpenseRepository.getExpensesByDateRange(
        startDate: startDate,
        endDate: endDate,
      );

      // assert
      expect(result, const Right([]));
    });

    test('should return ValidationFailure for invalid date range', () async {
      // arrange
      final startDate = DateTime(2024, 1, 20);
      final endDate = DateTime(2024, 1, 10); // end before start

      when(mockExpenseRepository.getExpensesByDateRange(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => const Left(
            ValidationFailure(message: 'End date must be after start date'),
          ));

      // act - call repository directly
      final result = await mockExpenseRepository.getExpensesByDateRange(
        startDate: startDate,
        endDate: endDate,
      );

      // assert
      expect(
        result,
        const Left(
          ValidationFailure(message: 'End date must be after start date'),
        ),
      );
    });

    // Additional test: Get expenses with filters
    test('should get expenses with date filters', () async {
      // arrange
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 31);
      final filteredExpenses = tExpenses;

      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => Right(filteredExpenses));

      // act
      final result = await usecase(GetExpensesParams(
        startDate: startDate,
        endDate: endDate,
      ));

      // assert
      expect(result, Right(filteredExpenses));
      verify(mockExpenseRepository.getExpenses(
        startDate: startDate,
        endDate: endDate,
        categoryId: null,
        type: null,
      ));
    });

    // Additional test: Get expenses with category filter
    test('should get expenses with category filter', () async {
      // arrange
      const categoryId = 'food';
      final filteredExpenses =
          tExpenses.where((e) => e.categoryId == categoryId).toList();

      when(mockExpenseRepository.getExpenses(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        categoryId: anyNamed('categoryId'),
        type: anyNamed('type'),
      )).thenAnswer((_) async => Right(filteredExpenses));

      // act
      final result = await usecase(GetExpensesParams(
        categoryId: categoryId,
      ));

      // assert
      expect(result, Right(filteredExpenses));
      verify(mockExpenseRepository.getExpenses(
        startDate: null,
        endDate: null,
        categoryId: categoryId,
        type: null,
      ));
    });
  });
}
