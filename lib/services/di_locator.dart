import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/constants/api_constants.dart' as api_consts;
import '../core/network/network_info.dart';
import '../core/network/network_info_impl.dart';
import '../data/data_sources/local/budget_local_data_source.dart';
import '../data/data_sources/local/budget_local_data_source_impl.dart';
import '../data/data_sources/local/expense_local_data_source.dart';
import '../data/data_sources/local/expense_local_data_source_impl.dart';
import '../data/data_sources/local/hive_service.dart';
import '../data/data_sources/remote/api_client.dart';
import '../data/data_sources/remote/budget_remote_data_source.dart';
import '../data/data_sources/remote/budget_remote_data_source_impl.dart';
import '../data/data_sources/remote/expense_remote_data_source.dart';
import '../data/data_sources/remote/expense_remote_data_source_impl.dart';
import '../data/data_sources/remote/firebase_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/budget_repository_impl.dart';
import '../data/repositories/category_repository_impl.dart';
import '../data/repositories/expense_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/budget_repository.dart';
import '../domain/repositories/category_repository.dart';
import '../presentation/providers/analytics_provider.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/providers/budget_provider.dart';
import '../presentation/providers/category_provider.dart';
import '../presentation/providers/expense_provider.dart';
import '../presentation/providers/theme_provider.dart';
import 'analytics_service.dart';
import 'storage_service.dart';
import 'sync_service.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Register external services
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<SyncService>(SyncService());
  getIt.registerSingleton<AnalyticsService>(AnalyticsService());
  getIt.registerSingleton<FirebaseStorageService>(FirebaseStorageService());

  // Register network info
  getIt.registerSingleton<NetworkInfo>(
      NetworkInfoImpl(connectivity: Connectivity()));

  // Register Data Sources
  getIt.registerSingleton<ExpenseLocalDataSource>(ExpenseLocalDataSourceImpl());
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerSingleton<ExpenseRemoteDataSource>(
      ExpenseRemoteDataSourceImpl(apiClient: getIt()));
  getIt.registerSingleton<BudgetLocalDataSource>(BudgetLocalDataSourceImpl());
  getIt.registerSingleton<BudgetRemoteDataSource>(BudgetRemoteDataSourceImpl(
    dio: Dio(),
    baseUrl: api_consts.ApiConstants.apiBaseUrl,
  ));

  // Register Repositories - using interface types from domain layer
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      networkInfo: getIt(),
      firebaseService: getIt(),
      hiveService: getIt(),
    ),
  );

  // FIX: Register as ExpenseRepository interface, not implementation
  getIt.registerSingleton<ExpenseRepository>(
    ExpenseRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  getIt.registerSingleton<BudgetRepository>(
    BudgetRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(
      hiveService: getIt(),
    ),
  );

  // Register Providers
  getIt.registerFactory<AuthProvider>(() => AuthProvider(repository: getIt()));
  getIt.registerFactory<ExpenseProvider>(
      () => ExpenseProvider(repository: getIt()));
  getIt.registerFactory<BudgetProvider>(
    () => BudgetProvider(
      budgetRepository: getIt(),
      expenseRepository: getIt(),
    ),
  );
  getIt.registerFactory<CategoryProvider>(
      () => CategoryProvider(repository: getIt()));
  getIt.registerFactory<AnalyticsProvider>(
    () => AnalyticsProvider(
      expenseRepository: getIt(),
      categoryRepository: getIt(),
    ),
  );
  getIt.registerFactory<ThemeProvider>(() => ThemeProvider());
}
