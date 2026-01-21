import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../models/adapters/budget_model_adapter.dart';
import '../../models/adapters/budget_period_adapter.dart';
import '../../models/budget_model.dart';
import '../../models/category_model.dart';
import '../../models/expense_model.dart';
import '../../models/user_model.dart';

class HiveService {
  static const String userBoxName = 'user';
  static const String expensesBoxName = 'expenses';
  static const String categoriesBoxName = 'categories';
  static const String budgetsBoxName = 'budgets';
  static const String settingsBoxName = 'settings';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(ExpenseModelAdapter());
    Hive.registerAdapter(ExpenseTypeAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(CategoryTypeAdapter());
    Hive.registerAdapter(BudgetModelAdapter());
    Hive.registerAdapter(BudgetPeriodAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(CategorySortByAdapter());
    Hive.registerAdapter(ExpenseSortByAdapter());

    // Open boxes
    await Hive.openBox<UserModel>(userBoxName);
    await Hive.openBox<ExpenseModel>(expensesBoxName);
    await Hive.openBox<CategoryModel>(categoriesBoxName);
    await Hive.openBox<BudgetModel>(budgetsBoxName);
    await Hive.openBox(settingsBoxName);
  }

  // User operations
  Future<UserModel?> getUser() async {
    try {
      final box = Hive.box<UserModel>(userBoxName);
      if (box.isEmpty) return null;
      return box.getAt(0);
    } catch (e) {
      throw CacheException(message: 'Failed to get user: ${e.toString()}');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      final box = Hive.box<UserModel>(userBoxName);
      await box.clear();
      await box.add(user);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to save user: ${e.toString()}',
      );
    }
  }

  Future<void> clearUser() async {
    try {
      final box = Hive.box<UserModel>(userBoxName);
      await box.clear();
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to clear user: ${e.toString()}',
      );
    }
  }

  // Category operations
  Future<List<CategoryModel>> getCategories() async {
    try {
      final box = Hive.box<CategoryModel>(categoriesBoxName);
      return box.values.where((c) => c.isActive).toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to get categories: ${e.toString()}',
      );
    }
  }

  Future<CategoryModel?> getCategoryById(String id) async {
    try {
      final box = Hive.box<CategoryModel>(categoriesBoxName);
      return box.get(id);
    } catch (e) {
      throw CacheException(message: 'Failed to get category: ${e.toString()}');
    }
  }

  Future<void> saveCategory(CategoryModel category) async {
    try {
      final box = Hive.box<CategoryModel>(categoriesBoxName);
      await box.put(category.id, category);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to save category: ${e.toString()}',
      );
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      final box = Hive.box<CategoryModel>(categoriesBoxName);
      await box.delete(id);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to delete category: ${e.toString()}',
      );
    }
  }

  Future<void> initializeDefaultCategories() async {
    try {
      final box = Hive.box<CategoryModel>(categoriesBoxName);
      if (box.isEmpty) {
        for (final category in DefaultCategories.allCategories) {
          await box.put(category.id, category);
        }
      }
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to initialize categories: ${e.toString()}',
      );
    }
  }

  // Budget operations
  Future<List<BudgetModel>> getBudgets() async {
    try {
      final box = Hive.box<BudgetModel>(budgetsBoxName);
      return box.values.where((b) => b.isActive).toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get budgets: ${e.toString()}');
    }
  }

  Future<BudgetModel?> getBudgetById(String id) async {
    try {
      final box = Hive.box<BudgetModel>(budgetsBoxName);
      return box.get(id);
    } catch (e) {
      throw CacheException(message: 'Failed to get budget: ${e.toString()}');
    }
  }

  Future<void> saveBudget(BudgetModel budget) async {
    try {
      final box = Hive.box<BudgetModel>(budgetsBoxName);
      await box.put(budget.id, budget);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to save budget: ${e.toString()}',
      );
    }
  }

  Future<void> deleteBudget(String id) async {
    try {
      final box = Hive.box<BudgetModel>(budgetsBoxName);
      await box.delete(id);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to delete budget: ${e.toString()}',
      );
    }
  }

  // Settings operations
  Future<T?> getSetting<T>(String key) async {
    try {
      final box = Hive.box(settingsBoxName);
      return box.get(key) as T?;
    } catch (e) {
      throw CacheException(message: 'Failed to get setting: ${e.toString()}');
    }
  }

  Future<void> saveSetting<T>(String key, T value) async {
    try {
      final box = Hive.box(settingsBoxName);
      await box.put(key, value);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to save setting: ${e.toString()}',
      );
    }
  }

  Future<void> deleteSetting(String key) async {
    try {
      final box = Hive.box(settingsBoxName);
      await box.delete(key);
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to delete setting: ${e.toString()}',
      );
    }
  }

  // Clear all data
  Future<void> clearAllData() async {
    try {
      await Hive.box<ExpenseModel>(expensesBoxName).clear();
      await Hive.box<CategoryModel>(categoriesBoxName).clear();
      await Hive.box<BudgetModel>(budgetsBoxName).clear();
      await Hive.box(settingsBoxName).clear();

      // Reinitialize default categories
      await initializeDefaultCategories();
    } catch (e) {
      throw StorageWriteException(
        message: 'Failed to clear all data: ${e.toString()}',
      );
    }
  }

  // Close all boxes
  static Future<void> close() async {
    await Hive.close();
  }

  // Delete all data and close
  static Future<void> deleteAllData() async {
    await Hive.deleteFromDisk();
  }
}
