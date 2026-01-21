import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_time_expense_tracker/domain/entities/budget.dart';

part 'budget_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BudgetModel extends Equatable {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'name', required: true)
  final String name;

  @JsonKey(name: 'category_id', required: true)
  final String categoryId;

  @JsonKey(name: 'amount', required: true)
  final double amount;

  @JsonKey(name: 'period', required: true)
  final int period;

  @JsonKey(name: 'start_date', required: true)
  final String startDate;

  @JsonKey(name: 'end_date', required: true)
  final String endDate;

  @JsonKey(name: 'spent', defaultValue: 0.0)
  final double spent;

  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  @JsonKey(name: 'notify_on_exceed', defaultValue: false)
  final bool notifyOnExceed;

  @JsonKey(name: 'warning_threshold')
  final double? warningThreshold;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'is_recurring', defaultValue: false)
  final bool isRecurring;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'notes')
  final String? notes;

  const BudgetModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.amount,
    required this.period,
    required this.startDate,
    required this.endDate,
    this.spent = 0.0,
    this.isActive = true,
    this.notifyOnExceed = false,
    this.warningThreshold,
    this.userId,
    this.description,
    this.isRecurring = false,
    this.createdAt,
    this.updatedAt,
    this.notes,
  });

  factory BudgetModel.fromEntity(Budget entity) {
    return BudgetModel(
      id: entity.id,
      name: entity.name,
      categoryId: entity.categoryId,
      amount: entity.amount,
      period: entity.period.index,
      startDate: entity.startDate.toIso8601String(),
      endDate: entity.endDate.toIso8601String(),
      spent: entity.spent,
      isActive: entity.isActive,
      notifyOnExceed: entity.notifyOnExceed,
      warningThreshold: entity.warningThreshold,
      userId: entity.userId,
      description: entity.description,
      isRecurring: entity.isRecurring,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
      notes: entity.notes,
    );
  }

  Budget toEntity() {
    return Budget(
      id: id,
      name: name,
      categoryId: categoryId,
      amount: amount,
      period: BudgetPeriod.values[period],
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      spent: spent,
      isActive: isActive,
      notifyOnExceed: notifyOnExceed,
      warningThreshold: warningThreshold,
      userId: userId,
      description: description,
      isRecurring: isRecurring,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      notes: notes,
    );
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        amount,
        period,
        startDate,
        endDate,
        spent,
        isActive,
        notifyOnExceed,
        warningThreshold,
        userId,
        description,
        isRecurring,
        createdAt,
        updatedAt,
        notes,
      ];
}
