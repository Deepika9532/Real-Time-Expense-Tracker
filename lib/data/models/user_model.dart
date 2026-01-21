import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 6)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) String? name,
    @HiveField(3) String? phoneNumber,
    @HiveField(4) String? profilePicture,
    @HiveField(5) @Default('USD') String currency,
    @HiveField(6) @Default('en') String language,
    @HiveField(7) UserPreferences? preferences,
    @HiveField(8) @Default(false) bool isPremium,
    @HiveField(9) DateTime? premiumExpiresAt,
    @HiveField(10) DateTime? createdAt,
    @HiveField(11) DateTime? updatedAt,
    @HiveField(12) DateTime? lastLoginAt,
    @HiveField(13) @Default(false) bool isEmailVerified,
    @HiveField(14) Map<String, dynamic>? metadata,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
@HiveType(typeId: 7)
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @HiveField(0) @Default(true) bool enableNotifications,
    @HiveField(1) @Default(true) bool enableBudgetAlerts,
    @HiveField(2) @Default(false) bool enableDailyReminders,
    @HiveField(3) @Default(true) bool enableSyncOnWifi,
    @HiveField(4) @Default(false) bool enableBiometricAuth,
    @HiveField(5) @Default(ThemeMode.system) ThemeMode themeMode,
    @HiveField(6) @Default('MM/dd/yyyy') String dateFormat,
    @HiveField(7) @Default(1) int startDayOfWeek,
    @HiveField(8) @Default(1) int startDayOfMonth,
    @HiveField(9) @Default(false) bool showDecimals,
    @HiveField(10) @Default(CategorySortBy.name) CategorySortBy categorySortBy,
    @HiveField(11) @Default(ExpenseSortBy.date) ExpenseSortBy expenseSortBy,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

@HiveType(typeId: 8)
enum ThemeMode {
  @HiveField(0)
  system,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
}

@HiveType(typeId: 9)
enum CategorySortBy {
  @HiveField(0)
  name,
  @HiveField(1)
  usage,
  @HiveField(2)
  amount,
  @HiveField(3)
  custom,
}

@HiveType(typeId: 10)
enum ExpenseSortBy {
  @HiveField(0)
  date,
  @HiveField(1)
  amount,
  @HiveField(2)
  category,
  @HiveField(3)
  title,
}

// Extension methods for UserModel
extension UserModelExtension on UserModel {
  // Get display name
  String get displayName => name ?? email.split('@').first;

  // Check if premium is active
  bool get isPremiumActive {
    if (!isPremium) return false;
    if (premiumExpiresAt == null) return true;
    return DateTime.now().isBefore(premiumExpiresAt!);
  }

  // Get days until premium expires
  int? get daysUntilPremiumExpires {
    if (!isPremium || premiumExpiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(premiumExpiresAt!)) return 0;
    return premiumExpiresAt!.difference(now).inDays;
  }

  // Get initials for avatar
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
}
