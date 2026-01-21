import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories({
    CategoryType? type,
  });

  Future<Either<Failure, Category>> getCategoryById(String id);

  Future<Either<Failure, Category>> createCategory(Category category);

  Future<Either<Failure, void>> updateCategory(Category category);

  Future<Either<Failure, void>> deleteCategory(String id);

  Future<Either<Failure, bool>> categoryExists(String id);

  Future<Either<Failure, List<Category>>> getDefaultCategories();
}
