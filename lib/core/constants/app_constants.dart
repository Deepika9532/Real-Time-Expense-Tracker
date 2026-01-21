class AppConstants {
  // App Info
  static const String appName = 'Real-Time Expense Tracker';
  static const String appVersion = '1.0.0';

  // Firebase Configuration
  static const String firebaseApiKey =
      "AIzaSyBjC4PEX3O3PP96VgNdbz83XXWJUu3QY5E";
  static const String firebaseAppId =
      "1:627202204044:web:4a1c58b15f0c9b7f0f0f0f";
  static const String firebaseMessagingSenderId = "627202204044";
  static const String firebaseProjectId = "realtimeexpensetracker-3feeb";
  static const String firebaseAuthDomain =
      "realtimeexpensetracker-3feeb.firebaseapp.com";
  static const String firebaseStorageBucket =
      "realtimeexpensetracker-3feeb.appspot.com";
  static const String firebaseMeasurementId = "G-XXXXXXXXXX";

  // API Endpoints
  static const String baseUrl = "https://your-api.com";

  // Padding & Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusExtraLarge = 16.0;

  // Animation Duration
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // General
  static const int maxRetryAttempts = 3;
  static const Duration apiTimeout = Duration(seconds: 30);

  // Pagination
  static const int itemsPerPage = 20;
  static const int maxPage = 10;

  // Storage Keys
  static const String hiveExpensesBox = 'expenses';
  static const String hivePrefsBox = 'app_preferences';
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
}
