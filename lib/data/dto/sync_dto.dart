import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/expense_model.dart';
import '../models/category_model.dart';
import '../models/budget_model.dart';

part 'sync_dto.freezed.dart';
part 'sync_dto.g.dart';

// DTO for sync request
@freezed
class SyncRequestDto with _$SyncRequestDto {
  const factory SyncRequestDto({
    required DateTime lastSyncTime,
    required String deviceId,
    required List<String> unsyncedExpenseIds,
    required List<String> unsyncedBudgetIds,
    String? userId,
  }) = _SyncRequestDto;

  factory SyncRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SyncRequestDtoFromJson(json);
}

// DTO for sync response
@freezed
class SyncResponseDto with _$SyncResponseDto {
  const factory SyncResponseDto({
    required DateTime syncTime,
    required List<ExpenseModel> expenses,
    required List<CategoryModel> categories,
    required List<BudgetModel> budgets,
    required List<String> deletedExpenseIds,
    required List<String> deletedBudgetIds,
    required SyncStatus status,
    String? message,
  }) = _SyncResponseDto;

  factory SyncResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SyncResponseDtoFromJson(json);
}

// DTO for sync status
@freezed
class SyncStatusDto with _$SyncStatusDto {
  const factory SyncStatusDto({
    required bool isSyncing,
    required DateTime? lastSyncTime,
    required int pendingChanges,
    required SyncStatus status,
    String? errorMessage,
  }) = _SyncStatusDto;

  factory SyncStatusDto.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusDtoFromJson(json);
}

// DTO for conflict resolution
@freezed
class ConflictDto with _$ConflictDto {
  const factory ConflictDto({
    required String id,
    required ConflictType type,
    required Map<String, dynamic> localData,
    required Map<String, dynamic> remoteData,
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) = _ConflictDto;

  factory ConflictDto.fromJson(Map<String, dynamic> json) =>
      _$ConflictDtoFromJson(json);
}

// DTO for batch sync
@freezed
class BatchSyncDto with _$BatchSyncDto {
  const factory BatchSyncDto({
    required List<ExpenseModel> expenses,
    required List<BudgetModel> budgets,
    required List<String> deletedIds,
    required String deviceId,
    required DateTime timestamp,
  }) = _BatchSyncDto;

  factory BatchSyncDto.fromJson(Map<String, dynamic> json) =>
      _$BatchSyncDtoFromJson(json);
}

// DTO for sync log
@freezed
class SyncLogDto with _$SyncLogDto {
  const factory SyncLogDto({
    required String id,
    required DateTime timestamp,
    required SyncStatus status,
    required int itemsSynced,
    required int itemsFailed,
    String? errorMessage,
    Map<String, dynamic>? metadata,
  }) = _SyncLogDto;

  factory SyncLogDto.fromJson(Map<String, dynamic> json) =>
      _$SyncLogDtoFromJson(json);
}

// Enums for sync
enum SyncStatus { idle, syncing, success, failed, conflict, partialSuccess }

enum ConflictType { expense, budget, category }

enum ConflictResolution { useLocal, useRemote, merge, skip }

// Extension methods for sync operations
extension SyncResponseDtoExtension on SyncResponseDto {
  bool get hasConflicts => status == SyncStatus.conflict;

  bool get isSuccessful =>
      status == SyncStatus.success || status == SyncStatus.partialSuccess;

  int get totalSyncedItems =>
      expenses.length + categories.length + budgets.length;
}

extension SyncStatusDtoExtension on SyncStatusDto {
  bool get canSync => !isSyncing && status != SyncStatus.syncing;

  bool get hasError => status == SyncStatus.failed;

  Duration? get timeSinceLastSync {
    if (lastSyncTime == null) return null;
    return DateTime.now().difference(lastSyncTime!);
  }

  bool get needsSync {
    if (pendingChanges > 0) return true;
    if (lastSyncTime == null) return true;

    // Sync if more than 1 hour since last sync
    final timeSince = timeSinceLastSync;
    return timeSince != null && timeSince.inHours >= 1;
  }
}

extension ConflictDtoExtension on ConflictDto {
  bool get localIsNewer => localUpdatedAt.isAfter(remoteUpdatedAt);

  bool get remoteIsNewer => remoteUpdatedAt.isAfter(localUpdatedAt);

  ConflictResolution get suggestedResolution {
    // Use the newer version by default
    if (localIsNewer) return ConflictResolution.useLocal;
    if (remoteIsNewer) return ConflictResolution.useRemote;
    return ConflictResolution.merge;
  }
}
