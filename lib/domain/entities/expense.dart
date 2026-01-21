import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? description;
  final ExpenseType type;
  final String? userId;
  final bool isSynced;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentMethod;
  final String? receiptImagePath;
  final Map<String, dynamic>? metadata;
  final String? receipt; // Changed to final

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.description,
    this.receiptImagePath,
    this.type = ExpenseType.expense,
    this.userId,
    this.isSynced = false,
    this.createdAt,
    this.updatedAt,
    this.paymentMethod,
    this.metadata,
    this.receipt, // Added to constructor
  });

  @override
  List<Object?> get props => [
        id,
        title,
        amount,
        categoryId,
        date,
        description,
        receiptImagePath,
        type,
        userId,
        isSynced,
        createdAt,
        updatedAt,
        paymentMethod,
        metadata,
        receipt, // Added to props
      ];

  // Helper methods
  bool isIncome() => type == ExpenseType.income;

  bool isExpense() => type == ExpenseType.expense;

  bool isFromToday() {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isFromThisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return date.isAfter(startOfWeek) || date.isAtSameMomentAs(startOfWeek);
  }

  bool isFromThisMonth() {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isFromThisYear() {
    final now = DateTime.now();
    return date.year == now.year;
  }

  // Copy with method
  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? description,
    String? receiptImagePath,
    ExpenseType? type,
    String? userId,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? paymentMethod,
    Map<String, dynamic>? metadata,
    String? receipt, // Added parameter
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      description: description ?? this.description,
      receiptImagePath: receiptImagePath ?? this.receiptImagePath,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      metadata: metadata ?? this.metadata,
      receipt: receipt ?? this.receipt, // Added
    );
  }
}

enum ExpenseType { expense, income }
