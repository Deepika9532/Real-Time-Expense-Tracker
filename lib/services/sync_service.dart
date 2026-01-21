import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

// Import your existing models
// import '../core/constants/api_constants.dart';
// import '../data/models/expense_model.dart';
// import '../data/models/category_model.dart';
// import '../data/models/user_model.dart';

// For now, we'll use placeholder imports
// You'll need to uncomment the above and comment these out
class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com/api';
}

// Placeholder - replace with your actual ExpenseModel
class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  DateTime updatedAt;
  String? syncStatus;
  String? syncId;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    DateTime? updatedAt,
    this.syncStatus,
    this.syncId,
  }) : updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'category': category,
        'date': date.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'syncStatus': syncStatus,
        'syncId': syncId,
      };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json['id'],
        title: json['title'],
        amount: json['amount'].toDouble(),
        category: json['category'],
        date: DateTime.parse(json['date']),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        syncStatus: json['syncStatus'],
        syncId: json['syncId'],
      );
}

// Placeholder - replace with your actual CategoryModel
class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json['id'], name: json['name']);
}

enum SyncStatus { idle, syncing, success, failed, conflict, offline }

enum SyncSource { local, remote, both }

// ========== SyncData Class ==========
class SyncData {
  DateTime timestamp;
  String? deviceId;
  String? userId;
  DateTime? lastSyncTime;
  List<ExpenseModel> expenses = [];
  List<CategoryModel> categories = [];

  SyncData({
    required this.timestamp,
    this.deviceId,
    this.userId,
    this.lastSyncTime,
  });
}

// ========== SyncDto Class ==========
class SyncDto {
  final DateTime timestamp;
  final String? deviceId;
  final String? userId;
  final DateTime? lastSyncTime;
  final List<ExpenseModel> expenses;
  final List<CategoryModel> categories;

  SyncDto({
    required this.timestamp,
    this.deviceId,
    this.userId,
    this.lastSyncTime,
    this.expenses = const [],
    this.categories = const [],
  });

  factory SyncDto.fromSyncData(SyncData data) {
    return SyncDto(
      timestamp: data.timestamp,
      deviceId: data.deviceId,
      userId: data.userId,
      lastSyncTime: data.lastSyncTime,
      expenses: data.expenses,
      categories: data.categories,
    );
  }

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'deviceId': deviceId,
        'userId': userId,
        'lastSyncTime': lastSyncTime?.toIso8601String(),
        'expenses': expenses.map((e) => e.toJson()).toList(),
        'categories': categories.map((c) => c.toJson()).toList(),
      };

  factory SyncDto.fromJson(Map<String, dynamic> json) => SyncDto(
        timestamp: DateTime.parse(json['timestamp']),
        deviceId: json['deviceId'],
        userId: json['userId'],
        lastSyncTime: json['lastSyncTime'] != null
            ? DateTime.parse(json['lastSyncTime'])
            : null,
        expenses: json['expenses'] != null
            ? List<ExpenseModel>.from(
                json['expenses'].map((x) => ExpenseModel.fromJson(x)))
            : [],
        categories: json['categories'] != null
            ? List<CategoryModel>.from(
                json['categories'].map((x) => CategoryModel.fromJson(x)))
            : [],
      );
}

// ========== StorageService Interface & Implementation ==========
abstract class StorageService {
  Future<void> initDatabase();
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveInt(String key, int value);
  Future<int?> getInt(String key);
  Future<void> saveBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> saveJson(String key, dynamic value);
  Future<dynamic> getJson(String key);
  Future<void> saveToDatabase<T>(String key, T value);
  Future<T?> getFromDatabase<T>(String key);
  Future<List<T>> getAllFromDatabase<T>();
  Future<void> deleteFromDatabase(String key);
  Future<void> clearDatabase();
}

class StorageServiceImpl implements StorageService {
  final Map<String, dynamic> _storage = {};

  @override
  Future<void> initDatabase() async {
    // Initialize your database here (e.g., Hive, SQLite, etc.)
    if (kDebugMode) {
      print('Database initialized');
    }
  }

  @override
  Future<void> saveString(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<String?> getString(String key) async {
    return _storage[key] as String?;
  }

  @override
  Future<void> saveInt(String key, int value) async {
    _storage[key] = value;
  }

  @override
  Future<int?> getInt(String key) async {
    return _storage[key] as int?;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    _storage[key] = value;
  }

  @override
  Future<bool?> getBool(String key) async {
    return _storage[key] as bool?;
  }

  @override
  Future<void> saveJson(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  Future<dynamic> getJson(String key) async {
    return _storage[key];
  }

  @override
  Future<void> saveToDatabase<T>(String key, T value) async {
    _storage[key] = value;
  }

  @override
  Future<T?> getFromDatabase<T>(String key) async {
    return _storage[key] as T?;
  }

  @override
  Future<List<T>> getAllFromDatabase<T>() async {
    final items = <T>[];
    for (final value in _storage.values) {
      if (value is T) {
        items.add(value);
      }
    }
    return items;
  }

  @override
  Future<void> deleteFromDatabase(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clearDatabase() async {
    _storage.clear();
  }
}

// ========== Main SyncService ==========
class SyncService {
  static final SyncService _instance = SyncService._internal();
  factory SyncService() => _instance;
  SyncService._internal();

  final StorageService _storageService = StorageServiceImpl();
  final Dio _dio = Dio();
  final Connectivity _connectivity = Connectivity();

  SyncStatus _status = SyncStatus.idle;
  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();
  final StreamController<double> _progressController =
      StreamController<double>.broadcast();

  Timer? _syncTimer;
  DateTime? _lastSyncTime;
  bool _isAutoSyncEnabled = true;
  int _syncInterval = 15; // minutes

  List<ExpenseModel> _pendingSyncExpenses = [];
  final List<Conflict> _conflicts = [];

  // Initialize sync service
  Future<void> initialize() async {
    await _storageService.initDatabase();

    // Load pending sync items
    await _loadPendingSyncItems();

    // Start connectivity listener
    _startConnectivityListener();

    // Start auto-sync timer
    if (_isAutoSyncEnabled) {
      _startAutoSync();
    }

    if (kDebugMode) {
      print('Sync service initialized');
    }
  }

  // Status stream
  Stream<SyncStatus> get statusStream => _statusController.stream;
  Stream<double> get progressStream => _progressController.stream;

  SyncStatus get status => _status;
  DateTime? get lastSyncTime => _lastSyncTime;

  // ========== Manual Sync Methods ==========

  Future<SyncResult> syncAllData() async {
    return await _performSync(SyncSource.both);
  }

  Future<SyncResult> syncFromCloud() async {
    return await _performSync(SyncSource.remote);
  }

  Future<SyncResult> syncToCloud() async {
    return await _performSync(SyncSource.local);
  }

  Future<SyncResult> _performSync(SyncSource source) async {
    try {
      _updateStatus(SyncStatus.syncing);

      // Check connectivity - FIXED for older connectivity_plus
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        _updateStatus(SyncStatus.offline);
        return SyncResult(
          success: false,
          message: 'No internet connection',
          syncedItems: 0,
          conflicts: 0,
        );
      }

      // Prepare sync data
      final syncData = await _prepareSyncData(source);

      // Upload data to server
      final uploadResult = await _uploadToServer(syncData);

      // Download updates from server
      final downloadResult = await _downloadFromServer();

      // Merge conflicts
      await _mergeConflicts();

      // Update last sync time
      _lastSyncTime = DateTime.now();
      await _storageService.saveString(
        'last_sync_time',
        _lastSyncTime!.toIso8601String(),
      );

      // Clear pending sync items
      _pendingSyncExpenses.clear();
      await _storageService.saveJson('pending_sync', []);

      _updateStatus(SyncStatus.success);

      return SyncResult(
        success: true,
        message: 'Sync completed successfully',
        syncedItems: uploadResult.syncedItems + downloadResult.syncedItems,
        conflicts: _conflicts.length,
        newExpenses: downloadResult.newExpenses,
        updatedExpenses: downloadResult.updatedExpenses,
      );
    } catch (e) {
      _updateStatus(SyncStatus.failed);

      if (kDebugMode) {
        print('Sync failed: $e');
      }

      return SyncResult(
        success: false,
        message: e.toString(),
        syncedItems: 0,
        conflicts: 0,
      );
    }
  }

  // ========== Data Preparation ==========

  Future<SyncData> _prepareSyncData(SyncSource source) async {
    final syncData = SyncData(
      timestamp: DateTime.now(),
      deviceId: await _getDeviceId(),
      userId: await _getUserId(),
    );

    if (source == SyncSource.local || source == SyncSource.both) {
      // Get local expenses that need sync
      final localExpenses = await _getLocalExpensesForSync();
      syncData.expenses = localExpenses;

      // Get pending sync expenses
      syncData.expenses.addAll(_pendingSyncExpenses);
    }

    if (source == SyncSource.remote || source == SyncSource.both) {
      // Get last sync time for incremental sync
      final lastSyncString = await _storageService.getString('last_sync_time');
      if (lastSyncString != null) {
        syncData.lastSyncTime = DateTime.parse(lastSyncString);
      }
    }

    return syncData;
  }

  Future<List<ExpenseModel>> _getLocalExpensesForSync() async {
    try {
      // Get all expenses from local database
      final allExpenses =
          await _storageService.getAllFromDatabase<ExpenseModel>();

      // Filter expenses that are modified after last sync
      return allExpenses.where((expense) {
        final isModified = expense.updatedAt.isAfter(
          _lastSyncTime ?? DateTime(1970),
        );
        final isNotSynced = expense.syncStatus != 'synced';
        return isModified || isNotSynced;
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get local expenses: $e');
      }
      return [];
    }
  }

  // ========== Server Communication ==========

  Future<UploadResult> _uploadToServer(SyncData syncData) async {
    try {
      _progressController.add(0.1);

      // Convert to DTO
      final syncDto = SyncDto.fromSyncData(syncData);

      // Upload to server
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/sync/upload',
        data: syncDto.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await _getAuthToken()}',
            'Content-Type': 'application/json',
          },
        ),
      );

      _progressController.add(0.5);

      if (response.statusCode == 200) {
        final result = UploadResult.fromJson(response.data);

        // Mark expenses as synced
        for (final expense in syncData.expenses) {
          expense.syncStatus = 'synced';
          expense.syncId = expense.id; // Use remote ID
          await _storageService.saveToDatabase(
            'expense_${expense.id}',
            expense,
          );
        }

        _progressController.add(1.0);
        return result;
      } else {
        throw Exception('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      // Save failed expenses for retry
      for (final expense in syncData.expenses) {
        expense.syncStatus = 'failed';
        _pendingSyncExpenses.add(expense);
      }
      await _savePendingSyncItems();
      rethrow;
    }
  }

  Future<DownloadResult> _downloadFromServer() async {
    try {
      _progressController.add(0.6);

      final response = await _dio.get(
        '${ApiConstants.baseUrl}/sync/download',
        queryParameters: {
          'last_sync': _lastSyncTime?.toIso8601String(),
          'device_id': await _getDeviceId(),
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${await _getAuthToken()}'},
        ),
      );

      _progressController.add(0.8);

      if (response.statusCode == 200) {
        final result = DownloadResult.fromJson(response.data);

        // Process downloaded items
        await _processDownloadedItems(result);

        _progressController.add(1.0);
        return result;
      } else {
        throw Exception('Download failed: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Download failed: $e');
      }
      rethrow;
    }
  }

  Future<void> _processDownloadedItems(DownloadResult result) async {
    // Process new expenses
    for (final expense in result.newExpenses) {
      final existingExpense =
          await _storageService.getFromDatabase<ExpenseModel>(
        'expense_${expense.id}',
      );

      if (existingExpense != null) {
        // Conflict detected
        _conflicts.add(Conflict(
          localItem: existingExpense,
          remoteItem: expense,
          type: ConflictType.expense,
        ));
      } else {
        // Save new expense
        await _storageService.saveToDatabase('expense_${expense.id}', expense);
      }
    }

    // Process updated expenses
    for (final expense in result.updatedExpenses) {
      final existingExpense =
          await _storageService.getFromDatabase<ExpenseModel>(
        'expense_${expense.id}',
      );

      if (existingExpense != null &&
          existingExpense.updatedAt.isAfter(expense.updatedAt)) {
        // Conflict: local is newer
        _conflicts.add(Conflict(
          localItem: existingExpense,
          remoteItem: expense,
          type: ConflictType.expense,
        ));
      } else {
        // Update expense
        await _storageService.saveToDatabase('expense_${expense.id}', expense);
      }
    }

    // Process deleted expenses
    for (final expenseId in result.deletedExpenseIds) {
      await _storageService.deleteFromDatabase('expense_$expenseId');
    }
  }

  // ========== Conflict Resolution ==========

  Future<void> _mergeConflicts() async {
    for (final conflict in _conflicts) {
      // Use local version by default (you can implement custom logic)
      await _storageService.saveToDatabase(
        'expense_${conflict.localItem.id}',
        conflict.localItem,
      );
    }

    // Clear resolved conflicts
    _conflicts.clear();
  }

  Future<void> resolveConflict(
    Conflict conflict, {
    bool useLocal = true,
  }) async {
    if (useLocal) {
      await _storageService.saveToDatabase(
        'expense_${conflict.localItem.id}',
        conflict.localItem,
      );
    } else {
      await _storageService.saveToDatabase(
        'expense_${conflict.remoteItem.id}',
        conflict.remoteItem,
      );
    }

    _conflicts.remove(conflict);
  }

  List<Conflict> getConflicts() => List.from(_conflicts);

  // ========== Auto Sync ==========

  void _startAutoSync() {
    _syncTimer = Timer.periodic(
      Duration(minutes: _syncInterval),
      (timer) async {
        if (_isAutoSyncEnabled && await _hasConnectivity()) {
          await syncAllData();
        }
      },
    );
  }

  void setAutoSync(bool enabled) {
    _isAutoSyncEnabled = enabled;

    if (enabled && _syncTimer == null) {
      _startAutoSync();
    } else if (!enabled && _syncTimer != null) {
      _syncTimer?.cancel();
      _syncTimer = null;
    }

    _storageService.saveBool('auto_sync_enabled', enabled);
  }

  void setSyncInterval(int minutes) {
    _syncInterval = minutes;
    _storageService.saveInt('sync_interval', minutes);

    // Restart timer with new interval
    _syncTimer?.cancel();
    if (_isAutoSyncEnabled) {
      _startAutoSync();
    }
  }

  // ========== Connectivity ==========

  void _startConnectivityListener() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (!results.contains(ConnectivityResult.none) &&
          _isAutoSyncEnabled &&
          _pendingSyncExpenses.isNotEmpty) {
        // Auto sync when connection is restored
        await syncToCloud();
      }
    });
  }

  Future<bool> _hasConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  // ========== Pending Sync Management ==========

  Future<void> _loadPendingSyncItems() async {
    final pendingJson = await _storageService.getJson('pending_sync');
    if (pendingJson != null && pendingJson is List) {
      _pendingSyncExpenses =
          pendingJson.map((e) => ExpenseModel.fromJson(e)).toList();
    }
  }

  Future<void> _savePendingSyncItems() async {
    final pendingJson = _pendingSyncExpenses.map((e) => e.toJson()).toList();
    await _storageService.saveJson('pending_sync', pendingJson);
  }

  void addExpenseForSync(ExpenseModel expense) {
    expense.syncStatus = 'pending';
    _pendingSyncExpenses.add(expense);
    _savePendingSyncItems();
  }

  List<ExpenseModel> getPendingSyncItems() => List.from(_pendingSyncExpenses);

  int getPendingSyncCount() => _pendingSyncExpenses.length;

  // ========== Utilities ==========

  Future<String> _getDeviceId() async {
    String? deviceId = await _storageService.getString('device_id');
    if (deviceId == null) {
      deviceId = DateTime.now().millisecondsSinceEpoch.toString();
      await _storageService.saveString('device_id', deviceId);
    }
    return deviceId;
  }

  Future<String?> _getUserId() async {
    final userJson = await _storageService.getJson('current_user');
    if (userJson != null && userJson is Map) {
      return userJson['id'] as String?;
    }
    return null;
  }

  Future<String?> _getAuthToken() async {
    return await _storageService.getString('auth_token');
  }

  void _updateStatus(SyncStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  // ========== Backup & Restore ==========

  Future<File> createBackup() async {
    final syncData = await _prepareSyncData(SyncSource.both);
    final syncDto = SyncDto.fromSyncData(syncData);

    final tempDir = await getTemporaryDirectory();
    final backupFile = File(
      '${tempDir.path}/backup_${DateTime.now().millisecondsSinceEpoch}.json',
    );

    await backupFile.writeAsString(jsonEncode(syncDto.toJson()));
    return backupFile;
  }

  Future<void> restoreFromBackup(File backupFile) async {
    try {
      final content = await backupFile.readAsString();
      final syncDto = SyncDto.fromJson(jsonDecode(content));

      // Clear existing data
      await _storageService.clearDatabase();

      // Restore expenses
      for (final expense in syncDto.expenses) {
        await _storageService.saveToDatabase('expense_${expense.id}', expense);
      }

      // Restore categories
      for (final category in syncDto.categories) {
        await _storageService.saveToDatabase(
          'category_${category.id}',
          category,
        );
      }

      if (kDebugMode) {
        print('Restore completed from backup');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Restore failed: $e');
      }
      rethrow;
    }
  }

  // ========== Cleanup ==========

  Future<void> dispose() async {
    _syncTimer?.cancel();
    _syncTimer = null;

    await _statusController.close();
    await _progressController.close();

    if (kDebugMode) {
      print('Sync service disposed');
    }
  }
}

// ========== Supporting Classes ==========

class SyncResult {
  final bool success;
  final String message;
  final int syncedItems;
  final int conflicts;
  final List<ExpenseModel>? newExpenses;
  final List<ExpenseModel>? updatedExpenses;

  SyncResult({
    required this.success,
    required this.message,
    required this.syncedItems,
    required this.conflicts,
    this.newExpenses,
    this.updatedExpenses,
  });
}

class UploadResult {
  final int syncedItems;
  final List<String> syncedIds;

  UploadResult({required this.syncedItems, required this.syncedIds});

  factory UploadResult.fromJson(Map<String, dynamic> json) {
    return UploadResult(
      syncedItems: json['synced_items'] as int,
      syncedIds: List<String>.from(json['synced_ids']),
    );
  }
}

class DownloadResult {
  final List<ExpenseModel> newExpenses;
  final List<ExpenseModel> updatedExpenses;
  final List<String> deletedExpenseIds;
  final int syncedItems;

  DownloadResult({
    required this.newExpenses,
    required this.updatedExpenses,
    required this.deletedExpenseIds,
    required this.syncedItems,
  });

  // Getters for compatibility
  List<ExpenseModel> get newItems => newExpenses;
  List<ExpenseModel> get updatedItems => updatedExpenses;

  factory DownloadResult.fromJson(Map<String, dynamic> json) {
    return DownloadResult(
      newExpenses: json['new_expenses'] != null
          ? List<ExpenseModel>.from(
              json['new_expenses'].map((x) => ExpenseModel.fromJson(x)))
          : [],
      updatedExpenses: json['updated_expenses'] != null
          ? List<ExpenseModel>.from(
              json['updated_expenses'].map((x) => ExpenseModel.fromJson(x)))
          : [],
      deletedExpenseIds: json['deleted_expense_ids'] != null
          ? List<String>.from(json['deleted_expense_ids'])
          : [],
      syncedItems: json['synced_items'] as int? ?? 0,
    );
  }
}

class Conflict {
  final dynamic localItem;
  final dynamic remoteItem;
  final ConflictType type;

  Conflict({
    required this.localItem,
    required this.remoteItem,
    required this.type,
  });
}

enum ConflictType { expense, category, budget }
