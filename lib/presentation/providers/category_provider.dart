import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/category.dart' as domain;
import '../../domain/repositories/category_repository.dart';

enum CategoryStatus { initial, loading, success, error }

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryProvider({required CategoryRepository repository})
      : _repository = repository {
    loadCategories();
  }

  // State
  CategoryStatus _status = CategoryStatus.initial;
  List<domain.Category> _categories = [];
  domain.Category? _selectedCategory;
  Failure? _failure;
  String? _errorMessage;

  // Filters
  domain.CategoryType? _selectedType;
  bool _showInactiveCategories = false;

  // Getters
  CategoryStatus get status => _status;
  List<domain.Category> get categories => _categories;
  domain.Category? get selectedCategory => _selectedCategory;
  Failure? get failure => _failure;
  String? get errorMessage => _errorMessage;
  domain.CategoryType? get selectedType => _selectedType;
  bool get showInactiveCategories => _showInactiveCategories;
  bool get isLoading => _status == CategoryStatus.loading;
  bool get hasError => _status == CategoryStatus.error;

  // Computed properties
  List<domain.Category> get activeCategories =>
      _categories.where((c) => c.isActive).toList();

  List<domain.Category> get expenseCategories => _categories
      .where((c) => c.type == domain.CategoryType.expense && c.isActive)
      .toList();

  List<domain.Category> get incomeCategories => _categories
      .where((c) => c.type == domain.CategoryType.income && c.isActive)
      .toList();

  List<domain.Category> get defaultCategories =>
      _categories.where((c) => c.isDefault).toList();

  List<domain.Category> get customCategories =>
      _categories.where((c) => !c.isDefault).toList();

  List<domain.Category> get filteredCategories {
    var filtered = _showInactiveCategories ? _categories : activeCategories;

    if (_selectedType != null) {
      filtered = filtered.where((c) => c.type == _selectedType).toList();
    }

    return filtered
      ..sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
  }

  // Load categories
  Future<void> loadCategories({bool refresh = false}) async {
    if (refresh || _categories.isEmpty) {
      _setStatus(CategoryStatus.loading);
    }

    final result = await _repository.getCategories();

    result.fold((failure) => _handleFailure(failure), (categories) {
      _categories = categories;
      _setStatus(CategoryStatus.success);
    });
  }

  // Get category by ID
  Future<void> getCategoryById(String id) async {
    _setStatus(CategoryStatus.loading);

    final result = await _repository.getCategoryById(id);

    result.fold((failure) => _handleFailure(failure), (category) {
      _selectedCategory = category;
      _setStatus(CategoryStatus.success);
    });
  }

  // Create category
  Future<bool> createCategory(domain.Category category) async {
    _setStatus(CategoryStatus.loading);

    final result = await _repository.createCategory(category);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (createdCategory) {
        _categories.add(createdCategory);
        _setStatus(CategoryStatus.success);
        return true;
      },
    );
  }

  // Update category
  Future<bool> updateCategory(domain.Category category) async {
    _setStatus(CategoryStatus.loading);

    final result = await _repository.updateCategory(category);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        final index = _categories.indexWhere((c) => c.id == category.id);
        if (index != -1) {
          _categories[index] = category;
        }
        if (_selectedCategory?.id == category.id) {
          _selectedCategory = category;
        }
        _setStatus(CategoryStatus.success);
        return true;
      },
    );
  }

  // Delete category
  Future<bool> deleteCategory(String id) async {
    _setStatus(CategoryStatus.loading);

    final result = await _repository.deleteCategory(id);

    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (_) {
        _categories.removeWhere((c) => c.id == id);
        if (_selectedCategory?.id == id) {
          _selectedCategory = null;
        }
        _setStatus(CategoryStatus.success);
        return true;
      },
    );
  }

  // Toggle category active status
  Future<bool> toggleCategoryStatus(String id) async {
    final category = _categories.firstWhere((c) => c.id == id);
    final updatedCategory = category.copyWith(isActive: !category.isActive);
    return await updateCategory(updatedCategory);
  }

  // Reorder categories
  Future<bool> reorderCategories(
      List<domain.Category> reorderedCategories) async {
    _setStatus(CategoryStatus.loading);

    // Update sort order for each category
    final updatedCategories = reorderedCategories
        .asMap()
        .entries
        .map((entry) => entry.value.copyWith(sortOrder: entry.key))
        .toList();

    // Update all categories
    bool success = true;
    for (final category in updatedCategories) {
      final result = await _repository.updateCategory(category);
      result.fold((failure) {
        _handleFailure(failure);
        success = false;
      }, (_) {});
      if (!success) break;
    }

    if (success) {
      _categories = updatedCategories;
      _setStatus(CategoryStatus.success);
    }

    return success;
  }

  // Get category by name
  domain.Category? getCategoryByName(String name) {
    try {
      return _categories.firstWhere(
        (c) => c.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Check if category name exists
  bool categoryNameExists(String name, {String? excludeId}) {
    return _categories.any(
      (c) =>
          c.name.toLowerCase() == name.toLowerCase() &&
          (excludeId == null || c.id != excludeId),
    );
  }

  // Get categories by type
  List<domain.Category> getCategoriesByType(domain.CategoryType type) {
    return _categories.where((c) => c.type == type && c.isActive).toList();
  }

  // Set type filter
  void setTypeFilter(domain.CategoryType? type) {
    _selectedType = type;
    notifyListeners();
  }

  // Toggle show inactive categories
  void toggleShowInactiveCategories() {
    _showInactiveCategories = !_showInactiveCategories;
    notifyListeners();
  }

  // Initialize default categories
  Future<void> initializeDefaultCategories() async {
    _setStatus(CategoryStatus.loading);

    // Since the repository doesn't have this method, we'll just reload
    await loadCategories(refresh: true);
  }

  // Select category
  void selectCategory(domain.Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Clear selected category
  void clearSelectedCategory() {
    _selectedCategory = null;
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedType = null;
    _showInactiveCategories = false;
    notifyListeners();
  }

  // Search categories
  List<domain.Category> searchCategories(String query) {
    if (query.isEmpty) return filteredCategories;

    final lowerQuery = query.toLowerCase();
    return filteredCategories
        .where(
          (c) =>
              c.name.toLowerCase().contains(lowerQuery) ||
              (c.description?.toLowerCase().contains(lowerQuery) ?? false),
        )
        .toList();
  }

  // Get category statistics
  Map<String, dynamic> getCategoryStatistics(String categoryId) {
    final category = _categories.firstWhere((c) => c.id == categoryId);

    return {
      'category': category,
      'totalTransactions': 0, // This would come from expense provider
      'totalAmount': 0.0, // This would come from expense provider
      'lastUsed': null, // This would come from expense provider
    };
  }

  // Validate category
  String? validateCategory(domain.Category category) {
    if (category.name.trim().isEmpty) {
      return 'Category name is required';
    }

    if (categoryNameExists(category.name, excludeId: category.id)) {
      return 'Category name already exists';
    }

    return null;
  }

  // Private methods
  void _setStatus(CategoryStatus status) {
    _status = status;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    _failure = failure;
    _errorMessage = failure.message;
    _setStatus(CategoryStatus.error);
  }

  // Clear error
  void clearError() {
    _failure = null;
    _errorMessage = null;
    if (_status == CategoryStatus.error) {
      _setStatus(CategoryStatus.initial);
    }
  }
}
