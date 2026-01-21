import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/expense_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class SyncExpenses implements UseCase<SyncResult, SyncExpensesParams> {
  final ExpenseRepository repository;

  SyncExpenses(this.repository);

  @override
  Future<Either<Failure, SyncResult>> call(SyncExpensesParams params) async {
    final startTime = DateTime.now();

    // Perform sync
    final syncResult = await repository.syncExpenses();

    return syncResult.fold((failure) => Left(failure), (_) async {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Get sync stats
      final stats = await _getSyncStats();

      return Right(
        SyncResult(
          success: true,
          syncedAt: endTime,
          duration: duration,
          stats: stats,
        ),
      );
    });
  }

  Future<SyncStats> _getSyncStats() async {
    // Get expense stats to determine sync status
    final statsResult = await repository.getExpenseStats();

    return statsResult.fold(
      (_) => const SyncStats(),
      (data) => SyncStats(
        totalItems: (data['count'] ?? 0).toInt(),
        lastSyncTime: DateTime.now(),
      ),
    );
  }
}

/// Force sync all data (useful for troubleshooting)
class ForceSyncExpenses implements UseCase<SyncResult, NoParams> {
  final ExpenseRepository repository;

  ForceSyncExpenses(this.repository);

  @override
  Future<Either<Failure, SyncResult>> call(NoParams params) async {
    final startTime = DateTime.now();

    final syncResult = await repository.syncExpenses();

    return syncResult.fold((failure) => Left(failure), (_) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      return Right(
        SyncResult(
          success: true,
          syncedAt: endTime,
          duration: duration,
          forced: true,
        ),
      );
    });
  }
}

/// Check sync status without performing sync
class CheckSyncStatus implements UseCase<SyncStats, NoParams> {
  final ExpenseRepository repository;

  CheckSyncStatus(this.repository);

  @override
  Future<Either<Failure, SyncStats>> call(NoParams params) async {
    final statsResult = await repository.getExpenseStats();

    return statsResult.fold((failure) => Left(failure), (data) {
      return Right(
        SyncStats(
          totalItems: (data['count'] ?? 0).toInt(),
          lastSyncTime: DateTime.now(),
        ),
      );
    });
  }
}

// Params
class SyncExpensesParams extends Equatable {
  final bool forceSync;
  final bool syncOnWifiOnly;

  const SyncExpensesParams({
    this.forceSync = false,
    this.syncOnWifiOnly = true,
  });

  @override
  List<Object?> get props => [forceSync, syncOnWifiOnly];
}

// Result classes
class SyncResult extends Equatable {
  final bool success;
  final DateTime syncedAt;
  final Duration duration;
  final SyncStats? stats;
  final bool forced;
  final String? errorMessage;

  const SyncResult({
    required this.success,
    required this.syncedAt,
    required this.duration,
    this.stats,
    this.forced = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    success,
    syncedAt,
    duration,
    stats,
    forced,
    errorMessage,
  ];
}

class SyncStats extends Equatable {
  final int totalItems;
  final int syncedItems;
  final int failedItems;
  final int pendingItems;
  final DateTime? lastSyncTime;

  const SyncStats({
    this.totalItems = 0,
    this.syncedItems = 0,
    this.failedItems = 0,
    this.pendingItems = 0,
    this.lastSyncTime,
  });

  bool get isFullySynced => pendingItems == 0 && failedItems == 0;

  bool get hasPendingItems => pendingItems > 0;

  bool get hasFailedItems => failedItems > 0;

  Duration? get timeSinceLastSync {
    if (lastSyncTime == null) return null;
    return DateTime.now().difference(lastSyncTime!);
  }

  @override
  List<Object?> get props => [
    totalItems,
    syncedItems,
    failedItems,
    pendingItems,
    lastSyncTime,
  ];
}
