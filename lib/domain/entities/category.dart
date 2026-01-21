import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CategoryType { expense, income, both }

class Category extends Equatable {
  final String id;
  final String name;
  final String icon;
  final int color;
  final CategoryType type;
  final String? description;
  final bool isDefault;
  final bool isActive;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.type = CategoryType.expense,
    this.description,
    this.isDefault = false,
    this.isActive = true,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.sortOrder,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        color,
        type,
        description,
        isDefault,
        isActive,
        userId,
        createdAt,
        updatedAt,
        sortOrder,
      ];

  // Helper methods
  Color get colorValue => Color(color);

  bool get canBeDeleted => !isDefault;

  bool get canBeEdited => !isDefault;

  bool isForExpense() =>
      type == CategoryType.expense || type == CategoryType.both;

  bool isForIncome() =>
      type == CategoryType.income || type == CategoryType.both;

  // Copy with method
  Category copyWith({
    String? id,
    String? name,
    String? icon,
    int? color,
    CategoryType? type,
    String? description,
    bool? isDefault,
    bool? isActive,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? sortOrder,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
      description: description ?? this.description,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  // For backward compatibility - you can also add these methods if needed
  bool get isExpense => type == CategoryType.expense;
  bool get isIncome => type == CategoryType.income;
  bool get isBoth => type == CategoryType.both;
}
