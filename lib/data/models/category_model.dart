// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
@HiveType(typeId: 2)
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String icon,
    @HiveField(3) required int color,
    @HiveField(4) @Default(CategoryType.expense) CategoryType type,
    @HiveField(5) String? description,
    @HiveField(6) @Default(false) bool isDefault,
    @HiveField(7) @Default(false) bool isActive,
    @HiveField(8) String? userId,
    @HiveField(9) DateTime? createdAt,
    @HiveField(10) DateTime? updatedAt,
    @HiveField(11) int? sortOrder,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@HiveType(typeId: 3)
enum CategoryType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
  @HiveField(2)
  both,
}

// Extension to get Color from int
extension CategoryModelExtension on CategoryModel {
  Color get colorValue => Color(color);
}

// Predefined categories
class DefaultCategories {
  static List<CategoryModel> get expenseCategories => [
        CategoryModel(
          id: 'cat_food',
          name: 'Food & Dining',
          icon: 'restaurant',
          // ignore: duplicate_ignore
          // ignore: deprecated_member_use
          color: Colors.orange.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_transport',
          name: 'Transportation',
          icon: 'directions_car',
          // ignore: duplicate_ignore
          // ignore: deprecated_member_use
          color: Colors.blue.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_shopping',
          name: 'Shopping',
          icon: 'shopping_bag',
          // ignore: duplicate_ignore
          // ignore: deprecated_member_use
          color: Colors.purple.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_entertainment',
          name: 'Entertainment',
          icon: 'movie',
          color: Colors.pink.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_health',
          name: 'Healthcare',
          icon: 'local_hospital',
          color: Colors.red.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_bills',
          name: 'Bills & Utilities',
          icon: 'receipt',
          color: Colors.brown.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_education',
          name: 'Education',
          icon: 'school',
          color: Colors.indigo.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_other',
          name: 'Other',
          icon: 'more_horiz',
          color: Colors.grey.value,
          type: CategoryType.expense,
          isDefault: true,
          isActive: true,
        ),
      ];

  static List<CategoryModel> get incomeCategories => [
        CategoryModel(
          id: 'cat_salary',
          name: 'Salary',
          icon: 'account_balance_wallet',
          color: Colors.green.value,
          type: CategoryType.income,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_business',
          name: 'Business',
          icon: 'business',
          color: Colors.teal.value,
          type: CategoryType.income,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_investment',
          name: 'Investment',
          icon: 'trending_up',
          color: Colors.lightGreen.value,
          type: CategoryType.income,
          isDefault: true,
          isActive: true,
        ),
        CategoryModel(
          id: 'cat_gift',
          name: 'Gift',
          icon: 'card_giftcard',
          color: Colors.amber.value,
          type: CategoryType.income,
          isDefault: true,
          isActive: true,
        ),
      ];

  static List<CategoryModel> get allCategories => [
        ...expenseCategories,
        ...incomeCategories,
      ];
}
