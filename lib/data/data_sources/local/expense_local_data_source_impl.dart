import 'package:hive/hive.dart';
import '../../../../core/errors/exceptions.dart';
import '../../models/expense_model.dart';
import '../local/expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  static const String boxName = 'expenses';

  Future<Box<ExpenseModel>> get _box async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<ExpenseModel>(boxName);
    }
    return Hive.box<ExpenseModel>(boxName);
  }

  @override
  Future<List<ExpenseModel>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
  }) async {
    try {
      final box = await _box;
      var expenses = box.values.toList();

      // Filter by date range
      if (startDate != null) {
        expenses = expenses
            .where(
              (e) =>
                  e.date.isAfter(startDate) ||
                  e.date.isAtSameMomentAs(startDate),
            )
            .toList();
      }
      if (endDate != null) {
        expenses = expenses
            .where(
              (e) =>
                  e.date.isBefore(endDate) || e.date.isAtSameMomentAs(endDate),
            )
            .toList();
      }

      // Filter by category
      if (categoryId != null) {
        expenses = expenses.where((e) => e.categoryId == categoryId).toList();
      }

      // Filter by type
      if (type != null) {
        expenses = expenses.where((e) => e.type == type).toList();
      }

      // Sort by date (newest first)
      expenses.sort((a, b) => b.date.compareTo(a.date));

      return expenses;
    } catch (e) {
      throw CacheException(message: 'Failed to get expenses: ${e.toString()}');
    }
  }

  @override
  Future<ExpenseModel> getExpenseById(String id) async {
    try {
      final box = await _box;
      final expense = box.get(id);

      if (expense == null) {
        throw NotFoundException(message: 'Expense not found with id: $id');
      }

      return expense;
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException(message: 'Failed to get expense: ${e.toString()}');
    }
  }

  @override
  Future<ExpenseModel> createExpense(ExpenseModel expense) async {
    try {
      final box = await _box;
      final now = DateTime.now();

      final newExpense = expense.copyWith(
        createdAt: now,
        updatedAt: now,
        isSynced: false,
      );

      await box.put(newExpense.id, newExpense);
      return newExpense;
    } catch (e) {
      throw CacheException(
        message: 'Failed to create expense: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      final box = await _box;

      if (!box.containsKey(expense.id)) {
        throw NotFoundException(
          message: 'Expense not found with id: ${expense.id}',
        );
      }

      final updatedExpense = expense.copyWith(updatedAt: DateTime.now());

      await box.put(updatedExpense.id, updatedExpense);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException(
        message: 'Failed to update expense: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      final box = await _box;

      if (!box.containsKey(id)) {
        throw NotFoundException(message: 'Expense not found with id: $id');
      }

      await box.delete(id);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException(
        message: 'Failed to delete expense: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<ExpenseModel>> searchExpenses(String query) async {
    try {
      final box = await _box;
      final expenses = box.values.toList();

      final lowerQuery = query.toLowerCase();

      final results = expenses.where((expense) {
        return expense.title.toLowerCase().contains(lowerQuery) ||
            (expense.description?.toLowerCase().contains(lowerQuery) ?? false);
      }).toList();

      // Sort by date (newest first)
      results.sort((a, b) => b.date.compareTo(a.date));

      return results;
    } catch (e) {
      throw CacheException(
        message: 'Failed to search expenses: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<ExpenseModel>> getUnsyncedExpenses() async {
    try {
      final box = await _box;
      final expenses = box.values.where((e) => !e.isSynced).toList();
      return expenses;
    } catch (e) {
      throw CacheException(
        message: 'Failed to get unsynced expenses: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearAllExpenses() async {
    try {
      final box = await _box;
      await box.clear();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear expenses: ${e.toString()}',
      );
    }
  }
}
