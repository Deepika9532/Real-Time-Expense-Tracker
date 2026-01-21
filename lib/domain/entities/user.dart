import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? profilePicture;
  final String currency;
  final String language;
  final UserPreferences? preferences;
  final bool isPremium;
  final DateTime? premiumExpiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;
  final bool isEmailVerified;
  final Map<String, dynamic>? metadata;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.phoneNumber,
    this.profilePicture,
    this.currency = 'USD',
    this.language = 'en',
    this.preferences,
    this.isPremium = false,
    this.premiumExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.isEmailVerified = false,
    this.metadata,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    profilePicture,
    currency,
    language,
    preferences,
    isPremium,
    premiumExpiresAt,
    createdAt,
    updatedAt,
    lastLoginAt,
    isEmailVerified,
    metadata,
  ];

  // Helper methods
  String get displayName => name ?? email.split('@').first;

  bool get isPremiumActive {
    if (!isPremium) return false;
    if (premiumExpiresAt == null) return true;
    return DateTime.now().isBefore(premiumExpiresAt!);
  }

  int? get daysUntilPremiumExpires {
    if (!isPremium || premiumExpiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(premiumExpiresAt!)) return 0;
    return premiumExpiresAt!.difference(now).inDays;
  }

  String get initials {
    if (name == null || name!.isEmpty) {
      return email.substring(0, 1).toUpperCase();
    }
    final parts = name!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name!.substring(0, 1).toUpperCase();
  }

  bool get hasCompletedProfile {
    return name != null && name!.isNotEmpty && isEmailVerified;
  }

  // Copy with method
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? profilePicture,
    String? currency,
    String? language,
    UserPreferences? preferences,
    bool? isPremium,
    DateTime? premiumExpiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      preferences: preferences ?? this.preferences,
      isPremium: isPremium ?? this.isPremium,
      premiumExpiresAt: premiumExpiresAt ?? this.premiumExpiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      metadata: metadata ?? this.metadata,
    );
  }
}

class UserPreferences extends Equatable {
  final bool enableNotifications;
  final bool enableBudgetAlerts;
  final bool enableDailyReminders;
  final bool enableSyncOnWifi;
  final bool enableBiometricAuth;
  final ThemeMode themeMode;
  final String dateFormat;
  final int startDayOfWeek;
  final int startDayOfMonth;
  final bool showDecimals;
  final CategorySortBy categorySortBy;
  final ExpenseSortBy expenseSortBy;

  const UserPreferences({
    this.enableNotifications = true,
    this.enableBudgetAlerts = true,
    this.enableDailyReminders = false,
    this.enableSyncOnWifi = true,
    this.enableBiometricAuth = false,
    this.themeMode = ThemeMode.system,
    this.dateFormat = 'MM/dd/yyyy',
    this.startDayOfWeek = 1,
    this.startDayOfMonth = 1,
    this.showDecimals = false,
    this.categorySortBy = CategorySortBy.name,
    this.expenseSortBy = ExpenseSortBy.date,
  });

  @override
  List<Object?> get props => [
    enableNotifications,
    enableBudgetAlerts,
    enableDailyReminders,
    enableSyncOnWifi,
    enableBiometricAuth,
    themeMode,
    dateFormat,
    startDayOfWeek,
    startDayOfMonth,
    showDecimals,
    categorySortBy,
    expenseSortBy,
  ];

  UserPreferences copyWith({
    bool? enableNotifications,
    bool? enableBudgetAlerts,
    bool? enableDailyReminders,
    bool? enableSyncOnWifi,
    bool? enableBiometricAuth,
    ThemeMode? themeMode,
    String? dateFormat,
    int? startDayOfWeek,
    int? startDayOfMonth,
    bool? showDecimals,
    CategorySortBy? categorySortBy,
    ExpenseSortBy? expenseSortBy,
  }) {
    return UserPreferences(
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableBudgetAlerts: enableBudgetAlerts ?? this.enableBudgetAlerts,
      enableDailyReminders: enableDailyReminders ?? this.enableDailyReminders,
      enableSyncOnWifi: enableSyncOnWifi ?? this.enableSyncOnWifi,
      enableBiometricAuth: enableBiometricAuth ?? this.enableBiometricAuth,
      themeMode: themeMode ?? this.themeMode,
      dateFormat: dateFormat ?? this.dateFormat,
      startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
      startDayOfMonth: startDayOfMonth ?? this.startDayOfMonth,
      showDecimals: showDecimals ?? this.showDecimals,
      categorySortBy: categorySortBy ?? this.categorySortBy,
      expenseSortBy: expenseSortBy ?? this.expenseSortBy,
    );
  }
}

enum ThemeMode { system, light, dark }

enum CategorySortBy { name, usage, amount, custom }

enum ExpenseSortBy { date, amount, category, title }
