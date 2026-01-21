import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/routes/app_routes.dart';
// Core
import 'core/theme/app_theme.dart';
// Data
import 'data/models/expense_model.dart';
// Firebase options
import 'firebase_options.dart';
import 'presentation/providers/analytics_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/category_provider.dart';
import 'presentation/providers/expense_provider.dart';
import 'presentation/providers/theme_provider.dart';
// Presentation
import 'presentation/screens/splash/splash_screen.dart';
// Services
import 'services/di_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  di.configureDependencies();

  // Initialize Firebase with platform-specific configuration
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      debugPrint('✅ Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('❌ Firebase initialization error: $e');
      debugPrint(
          'Running in debug mode - Firebase may not be fully configured');
    }
    // Continue without Firebase for development if needed
  }

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ExpenseModelAdapter());

  // Open Hive boxes
  await Hive.openBox<ExpenseModel>('expenses');
  await Hive.openBox('app_preferences');

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => di.getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<ExpenseProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<CategoryProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<AnalyticsProvider>())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.materialThemeMode,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: (settings) {
              // Delegate route generation to the route generator
              return AppRoutes.generateRoute(settings);
            },
            home:
                const AppStateWrapper(), // Use wrapper for auth state management
          );
        },
      ),
    );
  }
}

// AppState wrapper for Firebase auth state management
class AppStateWrapper extends StatelessWidget {
  const AppStateWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
      stream: Provider.of<AuthProvider>(context, listen: false).authState,
      builder: (context, snapshot) {
        // Show splash screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        final isLoggedIn = snapshot.hasData;

        if (isLoggedIn) {
          // Navigate to home screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          });
          return const SplashScreen(); // Show splash while redirecting
        } else {
          // Navigate to login screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
          return const SplashScreen(); // Show splash while redirecting
        }
      },
    );
  }
}
