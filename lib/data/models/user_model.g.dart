// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 6;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      email: fields[1] as String,
      name: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      profilePicture: fields[4] as String?,
      currency: fields[5] as String,
      language: fields[6] as String,
      preferences: fields[7] as UserPreferences?,
      isPremium: fields[8] as bool,
      premiumExpiresAt: fields[9] as DateTime?,
      createdAt: fields[10] as DateTime?,
      updatedAt: fields[11] as DateTime?,
      lastLoginAt: fields[12] as DateTime?,
      isEmailVerified: fields[13] as bool,
      metadata: (fields[14] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.currency)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.preferences)
      ..writeByte(8)
      ..write(obj.isPremium)
      ..writeByte(9)
      ..write(obj.premiumExpiresAt)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.lastLoginAt)
      ..writeByte(13)
      ..write(obj.isEmailVerified)
      ..writeByte(14)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 7;

  @override
  UserPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferences(
      enableNotifications: fields[0] as bool,
      enableBudgetAlerts: fields[1] as bool,
      enableDailyReminders: fields[2] as bool,
      enableSyncOnWifi: fields[3] as bool,
      enableBiometricAuth: fields[4] as bool,
      themeMode: fields[5] as ThemeMode,
      dateFormat: fields[6] as String,
      startDayOfWeek: fields[7] as int,
      startDayOfMonth: fields[8] as int,
      showDecimals: fields[9] as bool,
      categorySortBy: fields[10] as CategorySortBy,
      expenseSortBy: fields[11] as ExpenseSortBy,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.enableNotifications)
      ..writeByte(1)
      ..write(obj.enableBudgetAlerts)
      ..writeByte(2)
      ..write(obj.enableDailyReminders)
      ..writeByte(3)
      ..write(obj.enableSyncOnWifi)
      ..writeByte(4)
      ..write(obj.enableBiometricAuth)
      ..writeByte(5)
      ..write(obj.themeMode)
      ..writeByte(6)
      ..write(obj.dateFormat)
      ..writeByte(7)
      ..write(obj.startDayOfWeek)
      ..writeByte(8)
      ..write(obj.startDayOfMonth)
      ..writeByte(9)
      ..write(obj.showDecimals)
      ..writeByte(10)
      ..write(obj.categorySortBy)
      ..writeByte(11)
      ..write(obj.expenseSortBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 8;

  @override
  ThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.system:
        writer.writeByte(0);
        break;
      case ThemeMode.light:
        writer.writeByte(1);
        break;
      case ThemeMode.dark:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategorySortByAdapter extends TypeAdapter<CategorySortBy> {
  @override
  final int typeId = 9;

  @override
  CategorySortBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategorySortBy.name;
      case 1:
        return CategorySortBy.usage;
      case 2:
        return CategorySortBy.amount;
      case 3:
        return CategorySortBy.custom;
      default:
        return CategorySortBy.name;
    }
  }

  @override
  void write(BinaryWriter writer, CategorySortBy obj) {
    switch (obj) {
      case CategorySortBy.name:
        writer.writeByte(0);
        break;
      case CategorySortBy.usage:
        writer.writeByte(1);
        break;
      case CategorySortBy.amount:
        writer.writeByte(2);
        break;
      case CategorySortBy.custom:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorySortByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseSortByAdapter extends TypeAdapter<ExpenseSortBy> {
  @override
  final int typeId = 10;

  @override
  ExpenseSortBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseSortBy.date;
      case 1:
        return ExpenseSortBy.amount;
      case 2:
        return ExpenseSortBy.category;
      case 3:
        return ExpenseSortBy.title;
      default:
        return ExpenseSortBy.date;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseSortBy obj) {
    switch (obj) {
      case ExpenseSortBy.date:
        writer.writeByte(0);
        break;
      case ExpenseSortBy.amount:
        writer.writeByte(1);
        break;
      case ExpenseSortBy.category:
        writer.writeByte(2);
        break;
      case ExpenseSortBy.title:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSortByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePicture: json['profilePicture'] as String?,
      currency: json['currency'] as String? ?? 'USD',
      language: json['language'] as String? ?? 'en',
      preferences: json['preferences'] == null
          ? null
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
      isPremium: json['isPremium'] as bool? ?? false,
      premiumExpiresAt: json['premiumExpiresAt'] == null
          ? null
          : DateTime.parse(json['premiumExpiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'profilePicture': instance.profilePicture,
      'currency': instance.currency,
      'language': instance.language,
      'preferences': instance.preferences,
      'isPremium': instance.isPremium,
      'premiumExpiresAt': instance.premiumExpiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'isEmailVerified': instance.isEmailVerified,
      'metadata': instance.metadata,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      enableNotifications: json['enableNotifications'] as bool? ?? true,
      enableBudgetAlerts: json['enableBudgetAlerts'] as bool? ?? true,
      enableDailyReminders: json['enableDailyReminders'] as bool? ?? false,
      enableSyncOnWifi: json['enableSyncOnWifi'] as bool? ?? true,
      enableBiometricAuth: json['enableBiometricAuth'] as bool? ?? false,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      dateFormat: json['dateFormat'] as String? ?? 'MM/dd/yyyy',
      startDayOfWeek: (json['startDayOfWeek'] as num?)?.toInt() ?? 1,
      startDayOfMonth: (json['startDayOfMonth'] as num?)?.toInt() ?? 1,
      showDecimals: json['showDecimals'] as bool? ?? false,
      categorySortBy: $enumDecodeNullable(
              _$CategorySortByEnumMap, json['categorySortBy']) ??
          CategorySortBy.name,
      expenseSortBy:
          $enumDecodeNullable(_$ExpenseSortByEnumMap, json['expenseSortBy']) ??
              ExpenseSortBy.date,
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'enableNotifications': instance.enableNotifications,
      'enableBudgetAlerts': instance.enableBudgetAlerts,
      'enableDailyReminders': instance.enableDailyReminders,
      'enableSyncOnWifi': instance.enableSyncOnWifi,
      'enableBiometricAuth': instance.enableBiometricAuth,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'dateFormat': instance.dateFormat,
      'startDayOfWeek': instance.startDayOfWeek,
      'startDayOfMonth': instance.startDayOfMonth,
      'showDecimals': instance.showDecimals,
      'categorySortBy': _$CategorySortByEnumMap[instance.categorySortBy]!,
      'expenseSortBy': _$ExpenseSortByEnumMap[instance.expenseSortBy]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$CategorySortByEnumMap = {
  CategorySortBy.name: 'name',
  CategorySortBy.usage: 'usage',
  CategorySortBy.amount: 'amount',
  CategorySortBy.custom: 'custom',
};

const _$ExpenseSortByEnumMap = {
  ExpenseSortBy.date: 'date',
  ExpenseSortBy.amount: 'amount',
  ExpenseSortBy.category: 'category',
  ExpenseSortBy.title: 'title',
};
