import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expense_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Expenses table
    await db.execute('''
      CREATE TABLE expenses (
        id $idType,
        title $textType,
        amount $doubleType,
        categoryId $textType,
        date $textType,
        description TEXT,
        receipt TEXT,
        type $textType,
        userId TEXT,
        isSynced $boolType,
        createdAt TEXT,
        updatedAt TEXT,
        paymentMethod TEXT,
        metadata TEXT
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
        id $idType,
        name $textType,
        icon $textType,
        color $integerType,
        type $textType,
        description TEXT,
        isDefault $boolType,
        isActive $boolType,
        userId TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        sortOrder INTEGER
      )
    ''');

    // Budgets table
    await db.execute('''
      CREATE TABLE budgets (
        id $idType,
        name $textType,
        amount $doubleType,
        categoryId $textType,
        period $textType,
        startDate $textType,
        endDate $textType,
        spent $doubleType,
        isActive $boolType,
        notifyOnExceed $boolType,
        warningThreshold REAL,
        userId TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        notes TEXT,
        isRecurring $boolType
      )
    ''');

    // Create indexes for better query performance
    await db.execute('CREATE INDEX idx_expenses_date ON expenses(date)');
    await db.execute(
      'CREATE INDEX idx_expenses_categoryId ON expenses(categoryId)',
    );
    await db.execute('CREATE INDEX idx_expenses_userId ON expenses(userId)');
    await db.execute(
      'CREATE INDEX idx_budgets_categoryId ON budgets(categoryId)',
    );
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < newVersion) {
      // Add migration logic for future versions
    }
  }

  // Generic CRUD operations
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> clearTable(String table) async {
    final db = await database;
    await db.delete(table);
  }

  Future<void> clearAllTables() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('expenses');
      await txn.delete('categories');
      await txn.delete('budgets');
    });
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  // Backup and restore
  Future<String> getDatabasePath() async {
    final dbPath = await getDatabasesPath();
    return join(dbPath, 'expense_tracker.db');
  }

  Future<void> deleteDatabase() async {
    final path = await getDatabasePath();
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
