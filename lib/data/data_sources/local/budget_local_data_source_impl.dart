import 'package:hive/hive.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../domain/entities/budget.dart';
import '../../models/budget_model.dart';
import 'budget_local_data_source.dart';

class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  static const String budgetsBoxName = 'budgets';
  static const String syncBoxName = 'budgets_sync';
  static const String deletionsBoxName = 'budgets_deletions';

  @override
  Future<List<Budget>> getCachedBudgets() async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      return box.values
          .where((budget) => budget.isActive)
          .map((model) => model.toEntity())
          .toList();
    } catch (e) {
      throw CacheException(
          message: 'Failed to get cached budgets: ${e.toString()}');
    }
  }

  @override
  Future<Budget> getCachedBudgetById(String id) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final model = box.get(id);

      if (model == null) {
        throw CacheException(message: 'Budget not found in cache');
      }

      return model.toEntity();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
          message: 'Failed to get cached budget: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheBudget(Budget budget) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final model = BudgetModel.fromEntity(budget);
      await box.put(budget.id, model);
    } catch (e) {
      throw CacheException(message: 'Failed to cache budget: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheBudgets(List<Budget> budgets) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final models = {
        for (var budget in budgets) budget.id: BudgetModel.fromEntity(budget)
      };
      await box.putAll(models);
    } catch (e) {
      throw CacheException(message: 'Failed to cache budgets: ${e.toString()}');
    }
  }

  @override
  Future<void> saveBudget(Budget budget) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final model = BudgetModel.fromEntity(budget);
      await box.put(budget.id, model);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to save budget: ${e.toString()}');
    }
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final model = BudgetModel.fromEntity(budget);
      await box.put(budget.id, model);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to update budget: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteBudget(String id) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      await box.delete(id);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to delete budget: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getCachedBudgetsByPeriod(BudgetPeriod period) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      return box.values
          .where((model) =>
              model.isActive && BudgetPeriod.values[model.period] == period)
          .map((model) => model.toEntity())
          .toList();
    } catch (e) {
      throw CacheException(
          message: 'Failed to get cached budgets by period: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheBudgetsByPeriod(
      BudgetPeriod period, List<Budget> budgets) async {
    try {
      await cacheBudgets(budgets);
    } catch (e) {
      throw CacheException(
          message: 'Failed to cache budgets by period: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getCachedBudgetsByCategory(String categoryId) async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      return box.values
          .where((model) => model.isActive && model.categoryId == categoryId)
          .map((model) => model.toEntity())
          .toList();
    } catch (e) {
      throw CacheException(
          message: 'Failed to get cached budgets by category: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheBudgetsByCategory(
      String categoryId, List<Budget> budgets) async {
    try {
      await cacheBudgets(budgets);
    } catch (e) {
      throw CacheException(
          message: 'Failed to cache budgets by category: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getCachedActiveBudgets() async {
    try {
      final box = await Hive.openBox<BudgetModel>(budgetsBoxName);
      return box.values
          .where((model) => model.isActive)
          .map((model) => model.toEntity())
          .toList();
    } catch (e) {
      throw CacheException(
          message: 'Failed to get cached active budgets: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheActiveBudgets(List<Budget> budgets) async {
    try {
      await cacheBudgets(budgets);
    } catch (e) {
      throw CacheException(
          message: 'Failed to cache active budgets: ${e.toString()}');
    }
  }

  @override
  Future<void> markForSync(String id) async {
    try {
      final box = await Hive.openBox<String>(syncBoxName);
      await box.put(id, id);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to mark budget for sync: ${e.toString()}');
    }
  }

  @override
  Future<void> clearSyncMark(String id) async {
    try {
      final box = await Hive.openBox<String>(syncBoxName);
      await box.delete(id);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to clear sync mark: ${e.toString()}');
    }
  }

  @override
  Future<List<Budget>> getBudgetsMarkedForSync() async {
    try {
      final syncBox = await Hive.openBox<String>(syncBoxName);
      final budgetsBox = await Hive.openBox<BudgetModel>(budgetsBoxName);

      final budgets = <Budget>[];
      for (var id in syncBox.values) {
        final model = budgetsBox.get(id);
        if (model != null) {
          budgets.add(model.toEntity());
        }
      }

      return budgets;
    } catch (e) {
      throw CacheException(
          message: 'Failed to get budgets marked for sync: ${e.toString()}');
    }
  }

  @override
  Future<void> markDeletedForSync(String id) async {
    try {
      final box = await Hive.openBox<String>(deletionsBoxName);
      await box.put(id, id);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to mark deletion for sync: ${e.toString()}');
    }
  }

  @override
  Future<void> clearDeletionSyncMark(String id) async {
    try {
      final box = await Hive.openBox<String>(deletionsBoxName);
      await box.delete(id);
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to clear deletion sync mark: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getDeletionsMarkedForSync() async {
    try {
      final box = await Hive.openBox<String>(deletionsBoxName);
      return box.values.toList();
    } catch (e) {
      throw CacheException(
          message: 'Failed to get deletions marked for sync: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final budgetsBox = await Hive.openBox<BudgetModel>(budgetsBoxName);
      final syncBox = await Hive.openBox<String>(syncBoxName);
      final deletionsBox = await Hive.openBox<String>(deletionsBoxName);

      await budgetsBox.clear();
      await syncBox.clear();
      await deletionsBox.clear();
    } catch (e) {
      throw StorageWriteException(
          message: 'Failed to clear cache: ${e.toString()}');
    }
  }
}
