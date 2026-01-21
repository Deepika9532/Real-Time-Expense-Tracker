// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'category_id',
      'amount',
      'period',
      'start_date',
      'end_date'
    ],
  );
  return BudgetModel(
    id: json['id'] as String,
    name: json['name'] as String,
    categoryId: json['category_id'] as String,
    amount: (json['amount'] as num).toDouble(),
    period: (json['period'] as num).toInt(),
    startDate: json['start_date'] as String,
    endDate: json['end_date'] as String,
    spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
    isActive: json['is_active'] as bool? ?? true,
    notifyOnExceed: json['notify_on_exceed'] as bool? ?? false,
    warningThreshold: (json['warning_threshold'] as num?)?.toDouble(),
    userId: json['user_id'] as String?,
    description: json['description'] as String?,
    isRecurring: json['is_recurring'] as bool? ?? false,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    notes: json['notes'] as String?,
  );
}

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'period': instance.period,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'spent': instance.spent,
      'is_active': instance.isActive,
      'notify_on_exceed': instance.notifyOnExceed,
      'warning_threshold': instance.warningThreshold,
      'user_id': instance.userId,
      'description': instance.description,
      'is_recurring': instance.isRecurring,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'notes': instance.notes,
    };
