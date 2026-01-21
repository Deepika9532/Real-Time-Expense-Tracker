import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'core/theme/app_theme.dart';

import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/expense_provider.dart';
import 'presentation/providers/budget_provider.dart';
import 'presentation/providers/category_provider.dart';
import 'presentation/providers/analytics_provider.dart';

import 'services/di_locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // =====================
        // Theme Provider
        // =====================
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => di.getIt<ThemeProvider>(),
        ),

        // =====================
        // Auth Provider (eager)
        // =====================
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => di.getIt<AuthProvider>(),
          lazy: false,
        ),

        // =====================
        // Feature Providers
        // =====================
        ChangeNotifierProvider<ExpenseProvider>(
          create: (_) => di.getIt<ExpenseProvider>(),
        ),
        ChangeNotifierProvider<BudgetProvider>(
          create: (_) => di.getIt<BudgetProvider>(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => di.getIt<CategoryProvider>(),
        ),
        ChangeNotifierProvider<AnalyticsProvider>(
          create: (_) => di.getIt<AnalyticsProvider>(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Real Time Expense Tracker',
            debugShowCheckedModeBanner: false,

            // =====================
            // Theme
            // =====================
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.materialThemeMode,

            // =====================
            // Navigation
            // =====================
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
