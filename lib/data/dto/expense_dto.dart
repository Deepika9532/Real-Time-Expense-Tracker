import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/expense_model.dart';

part 'expense_dto.freezed.dart';
part 'expense_dto.g.dart';

// DTO for creating expense
@freezed
class CreateExpenseDto with _$CreateExpenseDto {
  const factory CreateExpenseDto({
    required String title,
    required double amount,
    required String categoryId,
    required DateTime date,
    String? description,
    String? receipt,
    @Default(ExpenseType.expense) ExpenseType type,
    String? paymentMethod,
    Map<String, dynamic>? metadata,
  }) = _CreateExpenseDto;

  factory CreateExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseDtoFromJson(json);
}

// DTO for updating expense
@freezed
class UpdateExpenseDto with _$UpdateExpenseDto {
  const factory UpdateExpenseDto({
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? description,
    String? receipt,
    ExpenseType? type,
    String? paymentMethod,
    Map<String, dynamic>? metadata,
  }) = _UpdateExpenseDto;

  factory UpdateExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateExpenseDtoFromJson(json);
}

// DTO for expense filters
@freezed
class ExpenseFilterDto with _$ExpenseFilterDto {
  const factory ExpenseFilterDto({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    ExpenseType? type,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
    ExpenseSortField? sortBy,
    @Default(SortOrder.descending) SortOrder sortOrder,
    @Default(0) int page,
    @Default(20) int limit,
  }) = _ExpenseFilterDto;

  factory ExpenseFilterDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFilterDtoFromJson(json);
}

// DTO for expense statistics
@freezed
class ExpenseStatsDto with _$ExpenseStatsDto {
  const factory ExpenseStatsDto({
    required double totalExpense,
    required double totalIncome,
    required double balance,
    required int transactionCount,
    required Map<String, double> categoryBreakdown,
    required Map<String, double> monthlyTrend,
    DateTime? startDate,
    DateTime? endDate,
  }) = _ExpenseStatsDto;

  factory ExpenseStatsDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseStatsDtoFromJson(json);
}

// DTO for bulk expense operations
@freezed
class BulkExpenseDto with _$BulkExpenseDto {
  const factory BulkExpenseDto({
    required List<String> expenseIds,
    required BulkOperation operation,
    Map<String, dynamic>? operationData,
  }) = _BulkExpenseDto;

  factory BulkExpenseDto.fromJson(Map<String, dynamic> json) =>
      _$BulkExpenseDtoFromJson(json);
}

// Enums for DTOs
enum ExpenseSortField { date, amount, title, category, createdAt }

enum SortOrder { ascending, descending }

enum BulkOperation { delete, updateCategory, export, archive }

// Extension methods for DTO conversions
extension CreateExpenseDtoExtension on CreateExpenseDto {
  ExpenseModel toModel(String id, String userId) {
    return ExpenseModel(
      id: id,
      title: title,
      amount: amount,
      categoryId: categoryId,
      date: date,
      description: description,
      receipt: receipt,
      type: type,
      userId: userId,
      paymentMethod: paymentMethod,
      metadata: metadata,
      isSynced: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

extension UpdateExpenseDtoExtension on UpdateExpenseDto {
  ExpenseModel applyTo(ExpenseModel expense) {
    return expense.copyWith(
      title: title ?? expense.title,
      amount: amount ?? expense.amount,
      categoryId: categoryId ?? expense.categoryId,
      date: date ?? expense.date,
      description: description ?? expense.description,
      receipt: receipt ?? expense.receipt,
      type: type ?? expense.type,
      paymentMethod: paymentMethod ?? expense.paymentMethod,
      metadata: metadata ?? expense.metadata,
      updatedAt: DateTime.now(),
      isSynced: false,
    );
  }
}
