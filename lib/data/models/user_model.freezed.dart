// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get email => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get phoneNumber => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get profilePicture => throw _privateConstructorUsedError;
  @HiveField(5)
  String get currency => throw _privateConstructorUsedError;
  @HiveField(6)
  String get language => throw _privateConstructorUsedError;
  @HiveField(7)
  UserPreferences? get preferences => throw _privateConstructorUsedError;
  @HiveField(8)
  bool get isPremium => throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime? get premiumExpiresAt => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(12)
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  @HiveField(13)
  bool get isEmailVerified => throw _privateConstructorUsedError;
  @HiveField(14)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String? name,
      @HiveField(3) String? phoneNumber,
      @HiveField(4) String? profilePicture,
      @HiveField(5) String currency,
      @HiveField(6) String language,
      @HiveField(7) UserPreferences? preferences,
      @HiveField(8) bool isPremium,
      @HiveField(9) DateTime? premiumExpiresAt,
      @HiveField(10) DateTime? createdAt,
      @HiveField(11) DateTime? updatedAt,
      @HiveField(12) DateTime? lastLoginAt,
      @HiveField(13) bool isEmailVerified,
      @HiveField(14) Map<String, dynamic>? metadata});

  $UserPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? currency = null,
    Object? language = null,
    Object? preferences = freezed,
    Object? isPremium = null,
    Object? premiumExpiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? isEmailVerified = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      premiumExpiresAt: freezed == premiumExpiresAt
          ? _value.premiumExpiresAt
          : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $UserPreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String? name,
      @HiveField(3) String? phoneNumber,
      @HiveField(4) String? profilePicture,
      @HiveField(5) String currency,
      @HiveField(6) String language,
      @HiveField(7) UserPreferences? preferences,
      @HiveField(8) bool isPremium,
      @HiveField(9) DateTime? premiumExpiresAt,
      @HiveField(10) DateTime? createdAt,
      @HiveField(11) DateTime? updatedAt,
      @HiveField(12) DateTime? lastLoginAt,
      @HiveField(13) bool isEmailVerified,
      @HiveField(14) Map<String, dynamic>? metadata});

  @override
  $UserPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? currency = null,
    Object? language = null,
    Object? preferences = freezed,
    Object? isPremium = null,
    Object? premiumExpiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? isEmailVerified = null,
    Object? metadata = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      premiumExpiresAt: freezed == premiumExpiresAt
          ? _value.premiumExpiresAt
          : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.email,
      @HiveField(2) this.name,
      @HiveField(3) this.phoneNumber,
      @HiveField(4) this.profilePicture,
      @HiveField(5) this.currency = 'USD',
      @HiveField(6) this.language = 'en',
      @HiveField(7) this.preferences,
      @HiveField(8) this.isPremium = false,
      @HiveField(9) this.premiumExpiresAt,
      @HiveField(10) this.createdAt,
      @HiveField(11) this.updatedAt,
      @HiveField(12) this.lastLoginAt,
      @HiveField(13) this.isEmailVerified = false,
      @HiveField(14) final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String email;
  @override
  @HiveField(2)
  final String? name;
  @override
  @HiveField(3)
  final String? phoneNumber;
  @override
  @HiveField(4)
  final String? profilePicture;
  @override
  @JsonKey()
  @HiveField(5)
  final String currency;
  @override
  @JsonKey()
  @HiveField(6)
  final String language;
  @override
  @HiveField(7)
  final UserPreferences? preferences;
  @override
  @JsonKey()
  @HiveField(8)
  final bool isPremium;
  @override
  @HiveField(9)
  final DateTime? premiumExpiresAt;
  @override
  @HiveField(10)
  final DateTime? createdAt;
  @override
  @HiveField(11)
  final DateTime? updatedAt;
  @override
  @HiveField(12)
  final DateTime? lastLoginAt;
  @override
  @JsonKey()
  @HiveField(13)
  final bool isEmailVerified;
  final Map<String, dynamic>? _metadata;
  @override
  @HiveField(14)
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, phoneNumber: $phoneNumber, profilePicture: $profilePicture, currency: $currency, language: $language, preferences: $preferences, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, isEmailVerified: $isEmailVerified, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.premiumExpiresAt, premiumExpiresAt) ||
                other.premiumExpiresAt == premiumExpiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String email,
      @HiveField(2) final String? name,
      @HiveField(3) final String? phoneNumber,
      @HiveField(4) final String? profilePicture,
      @HiveField(5) final String currency,
      @HiveField(6) final String language,
      @HiveField(7) final UserPreferences? preferences,
      @HiveField(8) final bool isPremium,
      @HiveField(9) final DateTime? premiumExpiresAt,
      @HiveField(10) final DateTime? createdAt,
      @HiveField(11) final DateTime? updatedAt,
      @HiveField(12) final DateTime? lastLoginAt,
      @HiveField(13) final bool isEmailVerified,
      @HiveField(14) final Map<String, dynamic>? metadata}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get email;
  @override
  @HiveField(2)
  String? get name;
  @override
  @HiveField(3)
  String? get phoneNumber;
  @override
  @HiveField(4)
  String? get profilePicture;
  @override
  @HiveField(5)
  String get currency;
  @override
  @HiveField(6)
  String get language;
  @override
  @HiveField(7)
  UserPreferences? get preferences;
  @override
  @HiveField(8)
  bool get isPremium;
  @override
  @HiveField(9)
  DateTime? get premiumExpiresAt;
  @override
  @HiveField(10)
  DateTime? get createdAt;
  @override
  @HiveField(11)
  DateTime? get updatedAt;
  @override
  @HiveField(12)
  DateTime? get lastLoginAt;
  @override
  @HiveField(13)
  bool get isEmailVerified;
  @override
  @HiveField(14)
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  @HiveField(0)
  bool get enableNotifications => throw _privateConstructorUsedError;
  @HiveField(1)
  bool get enableBudgetAlerts => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get enableDailyReminders => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get enableSyncOnWifi => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get enableBiometricAuth => throw _privateConstructorUsedError;
  @HiveField(5)
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  @HiveField(6)
  String get dateFormat => throw _privateConstructorUsedError;
  @HiveField(7)
  int get startDayOfWeek => throw _privateConstructorUsedError;
  @HiveField(8)
  int get startDayOfMonth => throw _privateConstructorUsedError;
  @HiveField(9)
  bool get showDecimals => throw _privateConstructorUsedError;
  @HiveField(10)
  CategorySortBy get categorySortBy => throw _privateConstructorUsedError;
  @HiveField(11)
  ExpenseSortBy get expenseSortBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {@HiveField(0) bool enableNotifications,
      @HiveField(1) bool enableBudgetAlerts,
      @HiveField(2) bool enableDailyReminders,
      @HiveField(3) bool enableSyncOnWifi,
      @HiveField(4) bool enableBiometricAuth,
      @HiveField(5) ThemeMode themeMode,
      @HiveField(6) String dateFormat,
      @HiveField(7) int startDayOfWeek,
      @HiveField(8) int startDayOfMonth,
      @HiveField(9) bool showDecimals,
      @HiveField(10) CategorySortBy categorySortBy,
      @HiveField(11) ExpenseSortBy expenseSortBy});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableNotifications = null,
    Object? enableBudgetAlerts = null,
    Object? enableDailyReminders = null,
    Object? enableSyncOnWifi = null,
    Object? enableBiometricAuth = null,
    Object? themeMode = null,
    Object? dateFormat = null,
    Object? startDayOfWeek = null,
    Object? startDayOfMonth = null,
    Object? showDecimals = null,
    Object? categorySortBy = null,
    Object? expenseSortBy = null,
  }) {
    return _then(_value.copyWith(
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBudgetAlerts: null == enableBudgetAlerts
          ? _value.enableBudgetAlerts
          : enableBudgetAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDailyReminders: null == enableDailyReminders
          ? _value.enableDailyReminders
          : enableDailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSyncOnWifi: null == enableSyncOnWifi
          ? _value.enableSyncOnWifi
          : enableSyncOnWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBiometricAuth: null == enableBiometricAuth
          ? _value.enableBiometricAuth
          : enableBiometricAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      startDayOfWeek: null == startDayOfWeek
          ? _value.startDayOfWeek
          : startDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      startDayOfMonth: null == startDayOfMonth
          ? _value.startDayOfMonth
          : startDayOfMonth // ignore: cast_nullable_to_non_nullable
              as int,
      showDecimals: null == showDecimals
          ? _value.showDecimals
          : showDecimals // ignore: cast_nullable_to_non_nullable
              as bool,
      categorySortBy: null == categorySortBy
          ? _value.categorySortBy
          : categorySortBy // ignore: cast_nullable_to_non_nullable
              as CategorySortBy,
      expenseSortBy: null == expenseSortBy
          ? _value.expenseSortBy
          : expenseSortBy // ignore: cast_nullable_to_non_nullable
              as ExpenseSortBy,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) bool enableNotifications,
      @HiveField(1) bool enableBudgetAlerts,
      @HiveField(2) bool enableDailyReminders,
      @HiveField(3) bool enableSyncOnWifi,
      @HiveField(4) bool enableBiometricAuth,
      @HiveField(5) ThemeMode themeMode,
      @HiveField(6) String dateFormat,
      @HiveField(7) int startDayOfWeek,
      @HiveField(8) int startDayOfMonth,
      @HiveField(9) bool showDecimals,
      @HiveField(10) CategorySortBy categorySortBy,
      @HiveField(11) ExpenseSortBy expenseSortBy});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enableNotifications = null,
    Object? enableBudgetAlerts = null,
    Object? enableDailyReminders = null,
    Object? enableSyncOnWifi = null,
    Object? enableBiometricAuth = null,
    Object? themeMode = null,
    Object? dateFormat = null,
    Object? startDayOfWeek = null,
    Object? startDayOfMonth = null,
    Object? showDecimals = null,
    Object? categorySortBy = null,
    Object? expenseSortBy = null,
  }) {
    return _then(_$UserPreferencesImpl(
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBudgetAlerts: null == enableBudgetAlerts
          ? _value.enableBudgetAlerts
          : enableBudgetAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDailyReminders: null == enableDailyReminders
          ? _value.enableDailyReminders
          : enableDailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSyncOnWifi: null == enableSyncOnWifi
          ? _value.enableSyncOnWifi
          : enableSyncOnWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBiometricAuth: null == enableBiometricAuth
          ? _value.enableBiometricAuth
          : enableBiometricAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      startDayOfWeek: null == startDayOfWeek
          ? _value.startDayOfWeek
          : startDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      startDayOfMonth: null == startDayOfMonth
          ? _value.startDayOfMonth
          : startDayOfMonth // ignore: cast_nullable_to_non_nullable
              as int,
      showDecimals: null == showDecimals
          ? _value.showDecimals
          : showDecimals // ignore: cast_nullable_to_non_nullable
              as bool,
      categorySortBy: null == categorySortBy
          ? _value.categorySortBy
          : categorySortBy // ignore: cast_nullable_to_non_nullable
              as CategorySortBy,
      expenseSortBy: null == expenseSortBy
          ? _value.expenseSortBy
          : expenseSortBy // ignore: cast_nullable_to_non_nullable
              as ExpenseSortBy,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl(
      {@HiveField(0) this.enableNotifications = true,
      @HiveField(1) this.enableBudgetAlerts = true,
      @HiveField(2) this.enableDailyReminders = false,
      @HiveField(3) this.enableSyncOnWifi = true,
      @HiveField(4) this.enableBiometricAuth = false,
      @HiveField(5) this.themeMode = ThemeMode.system,
      @HiveField(6) this.dateFormat = 'MM/dd/yyyy',
      @HiveField(7) this.startDayOfWeek = 1,
      @HiveField(8) this.startDayOfMonth = 1,
      @HiveField(9) this.showDecimals = false,
      @HiveField(10) this.categorySortBy = CategorySortBy.name,
      @HiveField(11) this.expenseSortBy = ExpenseSortBy.date});

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final bool enableNotifications;
  @override
  @JsonKey()
  @HiveField(1)
  final bool enableBudgetAlerts;
  @override
  @JsonKey()
  @HiveField(2)
  final bool enableDailyReminders;
  @override
  @JsonKey()
  @HiveField(3)
  final bool enableSyncOnWifi;
  @override
  @JsonKey()
  @HiveField(4)
  final bool enableBiometricAuth;
  @override
  @JsonKey()
  @HiveField(5)
  final ThemeMode themeMode;
  @override
  @JsonKey()
  @HiveField(6)
  final String dateFormat;
  @override
  @JsonKey()
  @HiveField(7)
  final int startDayOfWeek;
  @override
  @JsonKey()
  @HiveField(8)
  final int startDayOfMonth;
  @override
  @JsonKey()
  @HiveField(9)
  final bool showDecimals;
  @override
  @JsonKey()
  @HiveField(10)
  final CategorySortBy categorySortBy;
  @override
  @JsonKey()
  @HiveField(11)
  final ExpenseSortBy expenseSortBy;

  @override
  String toString() {
    return 'UserPreferences(enableNotifications: $enableNotifications, enableBudgetAlerts: $enableBudgetAlerts, enableDailyReminders: $enableDailyReminders, enableSyncOnWifi: $enableSyncOnWifi, enableBiometricAuth: $enableBiometricAuth, themeMode: $themeMode, dateFormat: $dateFormat, startDayOfWeek: $startDayOfWeek, startDayOfMonth: $startDayOfMonth, showDecimals: $showDecimals, categorySortBy: $categorySortBy, expenseSortBy: $expenseSortBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.enableNotifications, enableNotifications) ||
                other.enableNotifications == enableNotifications) &&
            (identical(other.enableBudgetAlerts, enableBudgetAlerts) ||
                other.enableBudgetAlerts == enableBudgetAlerts) &&
            (identical(other.enableDailyReminders, enableDailyReminders) ||
                other.enableDailyReminders == enableDailyReminders) &&
            (identical(other.enableSyncOnWifi, enableSyncOnWifi) ||
                other.enableSyncOnWifi == enableSyncOnWifi) &&
            (identical(other.enableBiometricAuth, enableBiometricAuth) ||
                other.enableBiometricAuth == enableBiometricAuth) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.startDayOfWeek, startDayOfWeek) ||
                other.startDayOfWeek == startDayOfWeek) &&
            (identical(other.startDayOfMonth, startDayOfMonth) ||
                other.startDayOfMonth == startDayOfMonth) &&
            (identical(other.showDecimals, showDecimals) ||
                other.showDecimals == showDecimals) &&
            (identical(other.categorySortBy, categorySortBy) ||
                other.categorySortBy == categorySortBy) &&
            (identical(other.expenseSortBy, expenseSortBy) ||
                other.expenseSortBy == expenseSortBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      expenseSortBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
          {@HiveField(0) final bool enableNotifications,
          @HiveField(1) final bool enableBudgetAlerts,
          @HiveField(2) final bool enableDailyReminders,
          @HiveField(3) final bool enableSyncOnWifi,
          @HiveField(4) final bool enableBiometricAuth,
          @HiveField(5) final ThemeMode themeMode,
          @HiveField(6) final String dateFormat,
          @HiveField(7) final int startDayOfWeek,
          @HiveField(8) final int startDayOfMonth,
          @HiveField(9) final bool showDecimals,
          @HiveField(10) final CategorySortBy categorySortBy,
          @HiveField(11) final ExpenseSortBy expenseSortBy}) =
      _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  @HiveField(0)
  bool get enableNotifications;
  @override
  @HiveField(1)
  bool get enableBudgetAlerts;
  @override
  @HiveField(2)
  bool get enableDailyReminders;
  @override
  @HiveField(3)
  bool get enableSyncOnWifi;
  @override
  @HiveField(4)
  bool get enableBiometricAuth;
  @override
  @HiveField(5)
  ThemeMode get themeMode;
  @override
  @HiveField(6)
  String get dateFormat;
  @override
  @HiveField(7)
  int get startDayOfWeek;
  @override
  @HiveField(8)
  int get startDayOfMonth;
  @override
  @HiveField(9)
  bool get showDecimals;
  @override
  @HiveField(10)
  CategorySortBy get categorySortBy;
  @override
  @HiveField(11)
  ExpenseSortBy get expenseSortBy;
  @override
  @JsonKey(ignore: true)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
