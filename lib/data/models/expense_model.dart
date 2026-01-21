import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
@HiveType(typeId: 0)
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required double amount,
    @HiveField(3) required String categoryId,
    @HiveField(4) required DateTime date,
    @HiveField(5) String? description,
    @HiveField(6) String? receipt,
    @HiveField(7) @Default(ExpenseType.expense) ExpenseType type,
    @HiveField(8) String? userId,
    @HiveField(9) @Default(false) bool isSynced,
    @HiveField(10) DateTime? createdAt,
    @HiveField(11) DateTime? updatedAt,
    @HiveField(12) String? paymentMethod,
    @HiveField(13) Map<String, dynamic>? metadata,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}

@HiveType(typeId: 1)
enum ExpenseType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}
