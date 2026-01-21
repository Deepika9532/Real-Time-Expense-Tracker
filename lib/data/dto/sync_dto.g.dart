// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncRequestDtoImpl _$$SyncRequestDtoImplFromJson(Map<String, dynamic> json) =>
    _$SyncRequestDtoImpl(
      lastSyncTime: DateTime.parse(json['lastSyncTime'] as String),
      deviceId: json['deviceId'] as String,
      unsyncedExpenseIds: (json['unsyncedExpenseIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      unsyncedBudgetIds: (json['unsyncedBudgetIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$SyncRequestDtoImplToJson(
        _$SyncRequestDtoImpl instance) =>
    <String, dynamic>{
      'lastSyncTime': instance.lastSyncTime.toIso8601String(),
      'deviceId': instance.deviceId,
      'unsyncedExpenseIds': instance.unsyncedExpenseIds,
      'unsyncedBudgetIds': instance.unsyncedBudgetIds,
      'userId': instance.userId,
    };

_$SyncResponseDtoImpl _$$SyncResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncResponseDtoImpl(
      syncTime: DateTime.parse(json['syncTime'] as String),
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      budgets: (json['budgets'] as List<dynamic>)
          .map((e) => BudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      deletedExpenseIds: (json['deletedExpenseIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deletedBudgetIds: (json['deletedBudgetIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: $enumDecode(_$SyncStatusEnumMap, json['status']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$SyncResponseDtoImplToJson(
        _$SyncResponseDtoImpl instance) =>
    <String, dynamic>{
      'syncTime': instance.syncTime.toIso8601String(),
      'expenses': instance.expenses,
      'categories': instance.categories,
      'budgets': instance.budgets,
      'deletedExpenseIds': instance.deletedExpenseIds,
      'deletedBudgetIds': instance.deletedBudgetIds,
      'status': _$SyncStatusEnumMap[instance.status]!,
      'message': instance.message,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.idle: 'idle',
  SyncStatus.syncing: 'syncing',
  SyncStatus.success: 'success',
  SyncStatus.failed: 'failed',
  SyncStatus.conflict: 'conflict',
  SyncStatus.partialSuccess: 'partialSuccess',
};

_$SyncStatusDtoImpl _$$SyncStatusDtoImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatusDtoImpl(
      isSyncing: json['isSyncing'] as bool,
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      pendingChanges: (json['pendingChanges'] as num).toInt(),
      status: $enumDecode(_$SyncStatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$SyncStatusDtoImplToJson(_$SyncStatusDtoImpl instance) =>
    <String, dynamic>{
      'isSyncing': instance.isSyncing,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'pendingChanges': instance.pendingChanges,
      'status': _$SyncStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
    };

_$ConflictDtoImpl _$$ConflictDtoImplFromJson(Map<String, dynamic> json) =>
    _$ConflictDtoImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ConflictTypeEnumMap, json['type']),
      localData: json['localData'] as Map<String, dynamic>,
      remoteData: json['remoteData'] as Map<String, dynamic>,
      localUpdatedAt: DateTime.parse(json['localUpdatedAt'] as String),
      remoteUpdatedAt: DateTime.parse(json['remoteUpdatedAt'] as String),
    );

Map<String, dynamic> _$$ConflictDtoImplToJson(_$ConflictDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ConflictTypeEnumMap[instance.type]!,
      'localData': instance.localData,
      'remoteData': instance.remoteData,
      'localUpdatedAt': instance.localUpdatedAt.toIso8601String(),
      'remoteUpdatedAt': instance.remoteUpdatedAt.toIso8601String(),
    };

const _$ConflictTypeEnumMap = {
  ConflictType.expense: 'expense',
  ConflictType.budget: 'budget',
  ConflictType.category: 'category',
};

_$BatchSyncDtoImpl _$$BatchSyncDtoImplFromJson(Map<String, dynamic> json) =>
    _$BatchSyncDtoImpl(
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      budgets: (json['budgets'] as List<dynamic>)
          .map((e) => BudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      deletedIds: (json['deletedIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deviceId: json['deviceId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$BatchSyncDtoImplToJson(_$BatchSyncDtoImpl instance) =>
    <String, dynamic>{
      'expenses': instance.expenses,
      'budgets': instance.budgets,
      'deletedIds': instance.deletedIds,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$SyncLogDtoImpl _$$SyncLogDtoImplFromJson(Map<String, dynamic> json) =>
    _$SyncLogDtoImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: $enumDecode(_$SyncStatusEnumMap, json['status']),
      itemsSynced: (json['itemsSynced'] as num).toInt(),
      itemsFailed: (json['itemsFailed'] as num).toInt(),
      errorMessage: json['errorMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SyncLogDtoImplToJson(_$SyncLogDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': _$SyncStatusEnumMap[instance.status]!,
      'itemsSynced': instance.itemsSynced,
      'itemsFailed': instance.itemsFailed,
      'errorMessage': instance.errorMessage,
      'metadata': instance.metadata,
    };
