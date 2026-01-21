import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data Sources
import '../../data/data_sources/local/expense_local_data_source.dart';
import '../../data/data_sources/local/expense_local_data_source_impl.dart';
import '../../data/data_sources/local/budget_local_data_source.dart';
import '../../data/data_sources/local/budget_local_data_source_impl.dart';
import '../../data/data_sources/local/database_helper.dart';

// Remote Data Sources (if you have them)
// import '../../data/data_sources/remote/auth_remote_data_source.dart';
// import '../../data/data_sources/remote/auth_remote_data_source_impl.dart';

// Repositories
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/category_repository.dart' as category_repo;
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/budget_repository.dart' as budget_repo;
import '../../data/repositories/budget_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

// Use Cases
// import '../../domain/usecases/expense/create_expense.dart';
// import '../../domain/usecases/expense/get_expenses.dart';
// Add your other use cases here

// Providers
import '../../presentation/providers/expense_provider.dart';
import '../../presentation/providers/category_provider.dart';
import '../../presentation/providers/budget_provider.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/theme_provider.dart';

// Network
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

// Services
import '../../services/storage_service.dart';
import '../../services/analytics_service.dart';
import '../../services/notification_service.dart';

// Data Sources
import '../../data/data_sources/local/hive_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // ===========================
  // External Dependencies
  // ===========================

  // SharedPreferences - Async initialization
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // ===========================
  // Core
  // ===========================

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  // Database Helper
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // ===========================
  // Services
  // ===========================

  sl.registerLazySingleton<FirebaseStorageService>(
    () => FirebaseStorageService(),
  );

  sl.registerLazySingleton<AnalyticsService>(
    () => AnalyticsService(),
  );

  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );

  // ===========================
  // Data Sources
  // ===========================

  // Local Data Sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<BudgetLocalDataSource>(
    () => BudgetLocalDataSourceImpl(),
  );

  // Register HiveService
  sl.registerLazySingleton<HiveService>(() => HiveService());

  // Remote Data Sources (uncomment when you implement them)
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(client: sl()),
  // );

  // ===========================
  // Repositories
  // ===========================

  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<category_repo.CategoryRepository>(
    () => CategoryRepositoryImpl(
      hiveService: sl(),
    ),
  );

  sl.registerLazySingleton<budget_repo.BudgetRepository>(
    () => BudgetRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // IMPORTANT: Register AuthRepository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: sl(),
      firebaseService: sl(),
      hiveService: sl(),
    ),
  );

  // ===========================
  // Use Cases (Optional - if you're using use case pattern)
  // ===========================

  // Example:
  // sl.registerLazySingleton(() => CreateExpense(sl()));
  // sl.registerLazySingleton(() => GetExpenses(sl()));

  // ===========================
  // Providers (State Management)
  // ===========================

  // Use factory for providers since they need to be new instances
  sl.registerFactory(
    () => ExpenseProvider(repository: sl()),
  );

  sl.registerFactory(
    () => CategoryProvider(repository: sl()),
  );

  sl.registerFactory(
    () => BudgetProvider(
      budgetRepository: sl(),
      expenseRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthProvider(repository: sl()),
  );

  sl.registerFactory(
    () => ThemeProvider(),
  );
}

// Helper function to reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
  await initializeDependencies();
}
