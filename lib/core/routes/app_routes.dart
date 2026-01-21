import 'package:flutter/material.dart';

// Screens
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/add_expense/add_expense_screen.dart';
import '../../presentation/screens/analytics/analytics_screen.dart';
import '../../presentation/screens/budget/budget_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';

class AppRoutes {
  // =====================
  // Authentication Routes
  // =====================
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // ============
  // Main Routes
  // ============
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';

  // =================
  // Expense Features
  // =================
  static const String addExpense = '/add-expense';
  static const String analytics = '/analytics';
  static const String budget = '/budget';

  // =================
  // Generic Item CRUD
  // =================
  static const String itemList = '/items';
  static const String itemDetail = '/items/:id';
  static const String itemCreate = '/items/create';
  static const String itemEdit = '/items/:id/edit';

  // =================
  // Additional Routes
  // =================
  static const String notifications = '/notifications';
  static const String search = '/search';
  static const String about = '/about';
  static const String help = '/help';
  static const String testFirebase = '/test-firebase';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';

  // ============
  // Error Routes
  // ============
  static const String notFound = '/not-found';
  static const String error = '/error';

  // =========================
  // Helper Methods (Dynamic)
  // =========================
  static String itemDetailRoute(String id) => '/items/$id';
  static String itemEditRoute(String id) => '/items/$id/edit';

  // =====================
  // Static Routes Mapping
  // =====================
  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    addExpense: (context) => const AddExpenseScreen(),
    analytics: (context) => const AnalyticsScreen(),
    budget: (context) => const BudgetScreen(),
    profile: (context) => const ProfileScreen(),
  };

  // =====================
  // Route Generator
  // =====================
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add custom dynamic route handling here later
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
    }
  }
}
