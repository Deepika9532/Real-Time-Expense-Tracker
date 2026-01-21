import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/category.dart' as domain;
import '../../../domain/repositories/category_repository.dart';
import '../../data/data_sources/local/hive_service.dart';
import '../../data/models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final HiveService _hiveService;

  CategoryRepositoryImpl({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<Either<Failure, List<domain.Category>>> getCategories(
      {domain.CategoryType? type}) async {
    try {
      final categoryModels = await _hiveService.getCategories();

      List<domain.Category> categories = categoryModels
          .map((model) => domain.Category(
                id: model.id,
                name: model.name,
                icon: model.icon,
                color: model.color,
                type: _convertCategoryType(model.type),
                isActive: model.isActive,
                isDefault: model.isDefault,
                sortOrder: model.sortOrder,
                description: model.description,
              ))
          .toList();

      if (type != null) {
        categories =
            categories.where((category) => category.type == type).toList();
      }

      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.Category>> getCategoryById(String id) async {
    try {
      final categoryModel = await _hiveService.getCategoryById(id);

      if (categoryModel == null) {
        return Left(CacheFailure(message: 'Category not found'));
      }

      return Right(domain.Category(
        id: categoryModel.id,
        name: categoryModel.name,
        icon: categoryModel.icon,
        color: categoryModel.color,
        type: _convertCategoryType(categoryModel.type),
        isActive: categoryModel.isActive,
        isDefault: categoryModel.isDefault,
        sortOrder: categoryModel.sortOrder,
        description: categoryModel.description,
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.Category>> createCategory(
      domain.Category category) async {
    try {
      final categoryModel = CategoryModel(
        id: category.id,
        name: category.name,
        icon: category.icon,
        color: category.color,
        type: _convertDomainCategoryType(category.type),
        isActive: category.isActive,
        isDefault: category.isDefault,
        sortOrder: category.sortOrder,
        description: category.description,
      );

      await _hiveService.saveCategory(categoryModel);

      return Right(category);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(domain.Category category) async {
    try {
      final categoryModel = CategoryModel(
        id: category.id,
        name: category.name,
        icon: category.icon,
        color: category.color,
        type: _convertDomainCategoryType(category.type),
        isActive: category.isActive,
        isDefault: category.isDefault,
        sortOrder: category.sortOrder,
        description: category.description,
      );

      await _hiveService.saveCategory(categoryModel);

      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) async {
    try {
      await _hiveService.deleteCategory(id);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> categoryExists(String id) async {
    try {
      final categoryModel = await _hiveService.getCategoryById(id);
      return Right(categoryModel != null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<domain.Category>>> getDefaultCategories() async {
    try {
      final box = await _hiveService.getCategories();
      final categoryModels = box.where((model) => model.isDefault).toList();

      List<domain.Category> categories = categoryModels
          .map((model) => domain.Category(
                id: model.id,
                name: model.name,
                icon: model.icon,
                color: model.color,
                type: _convertCategoryType(model.type),
                isActive: model.isActive,
                isDefault: model.isDefault,
                sortOrder: model.sortOrder,
                description: model.description,
              ))
          .toList();

      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Helper methods to convert between data model and domain entity types
  domain.CategoryType _convertCategoryType(CategoryType modelType) {
    switch (modelType) {
      case CategoryType.expense:
        return domain.CategoryType.expense;
      case CategoryType.income:
        return domain.CategoryType.income;
      case CategoryType.both:
        return domain.CategoryType.both;
    }
  }

  CategoryType _convertDomainCategoryType(domain.CategoryType domainType) {
    switch (domainType) {
      case domain.CategoryType.expense:
        return CategoryType.expense;
      case domain.CategoryType.income:
        return CategoryType.income;
      case domain.CategoryType.both:
        return CategoryType.both;
    }
  }
}
