// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncRequestDto _$SyncRequestDtoFromJson(Map<String, dynamic> json) {
  return _SyncRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SyncRequestDto {
  DateTime get lastSyncTime => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  List<String> get unsyncedExpenseIds => throw _privateConstructorUsedError;
  List<String> get unsyncedBudgetIds => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncRequestDtoCopyWith<SyncRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncRequestDtoCopyWith<$Res> {
  factory $SyncRequestDtoCopyWith(
          SyncRequestDto value, $Res Function(SyncRequestDto) then) =
      _$SyncRequestDtoCopyWithImpl<$Res, SyncRequestDto>;
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      String deviceId,
      List<String> unsyncedExpenseIds,
      List<String> unsyncedBudgetIds,
      String? userId});
}

/// @nodoc
class _$SyncRequestDtoCopyWithImpl<$Res, $Val extends SyncRequestDto>
    implements $SyncRequestDtoCopyWith<$Res> {
  _$SyncRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncTime = null,
    Object? deviceId = null,
    Object? unsyncedExpenseIds = null,
    Object? unsyncedBudgetIds = null,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      unsyncedExpenseIds: null == unsyncedExpenseIds
          ? _value.unsyncedExpenseIds
          : unsyncedExpenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unsyncedBudgetIds: null == unsyncedBudgetIds
          ? _value.unsyncedBudgetIds
          : unsyncedBudgetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncRequestDtoImplCopyWith<$Res>
    implements $SyncRequestDtoCopyWith<$Res> {
  factory _$$SyncRequestDtoImplCopyWith(_$SyncRequestDtoImpl value,
          $Res Function(_$SyncRequestDtoImpl) then) =
      __$$SyncRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      String deviceId,
      List<String> unsyncedExpenseIds,
      List<String> unsyncedBudgetIds,
      String? userId});
}

/// @nodoc
class __$$SyncRequestDtoImplCopyWithImpl<$Res>
    extends _$SyncRequestDtoCopyWithImpl<$Res, _$SyncRequestDtoImpl>
    implements _$$SyncRequestDtoImplCopyWith<$Res> {
  __$$SyncRequestDtoImplCopyWithImpl(
      _$SyncRequestDtoImpl _value, $Res Function(_$SyncRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncTime = null,
    Object? deviceId = null,
    Object? unsyncedExpenseIds = null,
    Object? unsyncedBudgetIds = null,
    Object? userId = freezed,
  }) {
    return _then(_$SyncRequestDtoImpl(
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      unsyncedExpenseIds: null == unsyncedExpenseIds
          ? _value._unsyncedExpenseIds
          : unsyncedExpenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unsyncedBudgetIds: null == unsyncedBudgetIds
          ? _value._unsyncedBudgetIds
          : unsyncedBudgetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncRequestDtoImpl implements _SyncRequestDto {
  const _$SyncRequestDtoImpl(
      {required this.lastSyncTime,
      required this.deviceId,
      required final List<String> unsyncedExpenseIds,
      required final List<String> unsyncedBudgetIds,
      this.userId})
      : _unsyncedExpenseIds = unsyncedExpenseIds,
        _unsyncedBudgetIds = unsyncedBudgetIds;

  factory _$SyncRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncRequestDtoImplFromJson(json);

  @override
  final DateTime lastSyncTime;
  @override
  final String deviceId;
  final List<String> _unsyncedExpenseIds;
  @override
  List<String> get unsyncedExpenseIds {
    if (_unsyncedExpenseIds is EqualUnmodifiableListView)
      return _unsyncedExpenseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unsyncedExpenseIds);
  }

  final List<String> _unsyncedBudgetIds;
  @override
  List<String> get unsyncedBudgetIds {
    if (_unsyncedBudgetIds is EqualUnmodifiableListView)
      return _unsyncedBudgetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unsyncedBudgetIds);
  }

  @override
  final String? userId;

  @override
  String toString() {
    return 'SyncRequestDto(lastSyncTime: $lastSyncTime, deviceId: $deviceId, unsyncedExpenseIds: $unsyncedExpenseIds, unsyncedBudgetIds: $unsyncedBudgetIds, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncRequestDtoImpl &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            const DeepCollectionEquality()
                .equals(other._unsyncedExpenseIds, _unsyncedExpenseIds) &&
            const DeepCollectionEquality()
                .equals(other._unsyncedBudgetIds, _unsyncedBudgetIds) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastSyncTime,
      deviceId,
      const DeepCollectionEquality().hash(_unsyncedExpenseIds),
      const DeepCollectionEquality().hash(_unsyncedBudgetIds),
      userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncRequestDtoImplCopyWith<_$SyncRequestDtoImpl> get copyWith =>
      __$$SyncRequestDtoImplCopyWithImpl<_$SyncRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _SyncRequestDto implements SyncRequestDto {
  const factory _SyncRequestDto(
      {required final DateTime lastSyncTime,
      required final String deviceId,
      required final List<String> unsyncedExpenseIds,
      required final List<String> unsyncedBudgetIds,
      final String? userId}) = _$SyncRequestDtoImpl;

  factory _SyncRequestDto.fromJson(Map<String, dynamic> json) =
      _$SyncRequestDtoImpl.fromJson;

  @override
  DateTime get lastSyncTime;
  @override
  String get deviceId;
  @override
  List<String> get unsyncedExpenseIds;
  @override
  List<String> get unsyncedBudgetIds;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$SyncRequestDtoImplCopyWith<_$SyncRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncResponseDto _$SyncResponseDtoFromJson(Map<String, dynamic> json) {
  return _SyncResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SyncResponseDto {
  DateTime get syncTime => throw _privateConstructorUsedError;
  List<ExpenseModel> get expenses => throw _privateConstructorUsedError;
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  List<BudgetModel> get budgets => throw _privateConstructorUsedError;
  List<String> get deletedExpenseIds => throw _privateConstructorUsedError;
  List<String> get deletedBudgetIds => throw _privateConstructorUsedError;
  SyncStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncResponseDtoCopyWith<SyncResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncResponseDtoCopyWith<$Res> {
  factory $SyncResponseDtoCopyWith(
          SyncResponseDto value, $Res Function(SyncResponseDto) then) =
      _$SyncResponseDtoCopyWithImpl<$Res, SyncResponseDto>;
  @useResult
  $Res call(
      {DateTime syncTime,
      List<ExpenseModel> expenses,
      List<CategoryModel> categories,
      List<BudgetModel> budgets,
      List<String> deletedExpenseIds,
      List<String> deletedBudgetIds,
      SyncStatus status,
      String? message});
}

/// @nodoc
class _$SyncResponseDtoCopyWithImpl<$Res, $Val extends SyncResponseDto>
    implements $SyncResponseDtoCopyWith<$Res> {
  _$SyncResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syncTime = null,
    Object? expenses = null,
    Object? categories = null,
    Object? budgets = null,
    Object? deletedExpenseIds = null,
    Object? deletedBudgetIds = null,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      syncTime: null == syncTime
          ? _value.syncTime
          : syncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      budgets: null == budgets
          ? _value.budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetModel>,
      deletedExpenseIds: null == deletedExpenseIds
          ? _value.deletedExpenseIds
          : deletedExpenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deletedBudgetIds: null == deletedBudgetIds
          ? _value.deletedBudgetIds
          : deletedBudgetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncResponseDtoImplCopyWith<$Res>
    implements $SyncResponseDtoCopyWith<$Res> {
  factory _$$SyncResponseDtoImplCopyWith(_$SyncResponseDtoImpl value,
          $Res Function(_$SyncResponseDtoImpl) then) =
      __$$SyncResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime syncTime,
      List<ExpenseModel> expenses,
      List<CategoryModel> categories,
      List<BudgetModel> budgets,
      List<String> deletedExpenseIds,
      List<String> deletedBudgetIds,
      SyncStatus status,
      String? message});
}

/// @nodoc
class __$$SyncResponseDtoImplCopyWithImpl<$Res>
    extends _$SyncResponseDtoCopyWithImpl<$Res, _$SyncResponseDtoImpl>
    implements _$$SyncResponseDtoImplCopyWith<$Res> {
  __$$SyncResponseDtoImplCopyWithImpl(
      _$SyncResponseDtoImpl _value, $Res Function(_$SyncResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syncTime = null,
    Object? expenses = null,
    Object? categories = null,
    Object? budgets = null,
    Object? deletedExpenseIds = null,
    Object? deletedBudgetIds = null,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(_$SyncResponseDtoImpl(
      syncTime: null == syncTime
          ? _value.syncTime
          : syncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      budgets: null == budgets
          ? _value._budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetModel>,
      deletedExpenseIds: null == deletedExpenseIds
          ? _value._deletedExpenseIds
          : deletedExpenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deletedBudgetIds: null == deletedBudgetIds
          ? _value._deletedBudgetIds
          : deletedBudgetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncResponseDtoImpl implements _SyncResponseDto {
  const _$SyncResponseDtoImpl(
      {required this.syncTime,
      required final List<ExpenseModel> expenses,
      required final List<CategoryModel> categories,
      required final List<BudgetModel> budgets,
      required final List<String> deletedExpenseIds,
      required final List<String> deletedBudgetIds,
      required this.status,
      this.message})
      : _expenses = expenses,
        _categories = categories,
        _budgets = budgets,
        _deletedExpenseIds = deletedExpenseIds,
        _deletedBudgetIds = deletedBudgetIds;

  factory _$SyncResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncResponseDtoImplFromJson(json);

  @override
  final DateTime syncTime;
  final List<ExpenseModel> _expenses;
  @override
  List<ExpenseModel> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  final List<CategoryModel> _categories;
  @override
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<BudgetModel> _budgets;
  @override
  List<BudgetModel> get budgets {
    if (_budgets is EqualUnmodifiableListView) return _budgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgets);
  }

  final List<String> _deletedExpenseIds;
  @override
  List<String> get deletedExpenseIds {
    if (_deletedExpenseIds is EqualUnmodifiableListView)
      return _deletedExpenseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedExpenseIds);
  }

  final List<String> _deletedBudgetIds;
  @override
  List<String> get deletedBudgetIds {
    if (_deletedBudgetIds is EqualUnmodifiableListView)
      return _deletedBudgetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedBudgetIds);
  }

  @override
  final SyncStatus status;
  @override
  final String? message;

  @override
  String toString() {
    return 'SyncResponseDto(syncTime: $syncTime, expenses: $expenses, categories: $categories, budgets: $budgets, deletedExpenseIds: $deletedExpenseIds, deletedBudgetIds: $deletedBudgetIds, status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncResponseDtoImpl &&
            (identical(other.syncTime, syncTime) ||
                other.syncTime == syncTime) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._budgets, _budgets) &&
            const DeepCollectionEquality()
                .equals(other._deletedExpenseIds, _deletedExpenseIds) &&
            const DeepCollectionEquality()
                .equals(other._deletedBudgetIds, _deletedBudgetIds) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      syncTime,
      const DeepCollectionEquality().hash(_expenses),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_budgets),
      const DeepCollectionEquality().hash(_deletedExpenseIds),
      const DeepCollectionEquality().hash(_deletedBudgetIds),
      status,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncResponseDtoImplCopyWith<_$SyncResponseDtoImpl> get copyWith =>
      __$$SyncResponseDtoImplCopyWithImpl<_$SyncResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _SyncResponseDto implements SyncResponseDto {
  const factory _SyncResponseDto(
      {required final DateTime syncTime,
      required final List<ExpenseModel> expenses,
      required final List<CategoryModel> categories,
      required final List<BudgetModel> budgets,
      required final List<String> deletedExpenseIds,
      required final List<String> deletedBudgetIds,
      required final SyncStatus status,
      final String? message}) = _$SyncResponseDtoImpl;

  factory _SyncResponseDto.fromJson(Map<String, dynamic> json) =
      _$SyncResponseDtoImpl.fromJson;

  @override
  DateTime get syncTime;
  @override
  List<ExpenseModel> get expenses;
  @override
  List<CategoryModel> get categories;
  @override
  List<BudgetModel> get budgets;
  @override
  List<String> get deletedExpenseIds;
  @override
  List<String> get deletedBudgetIds;
  @override
  SyncStatus get status;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SyncResponseDtoImplCopyWith<_$SyncResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncStatusDto _$SyncStatusDtoFromJson(Map<String, dynamic> json) {
  return _SyncStatusDto.fromJson(json);
}

/// @nodoc
mixin _$SyncStatusDto {
  bool get isSyncing => throw _privateConstructorUsedError;
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;
  int get pendingChanges => throw _privateConstructorUsedError;
  SyncStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncStatusDtoCopyWith<SyncStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusDtoCopyWith<$Res> {
  factory $SyncStatusDtoCopyWith(
          SyncStatusDto value, $Res Function(SyncStatusDto) then) =
      _$SyncStatusDtoCopyWithImpl<$Res, SyncStatusDto>;
  @useResult
  $Res call(
      {bool isSyncing,
      DateTime? lastSyncTime,
      int pendingChanges,
      SyncStatus status,
      String? errorMessage});
}

/// @nodoc
class _$SyncStatusDtoCopyWithImpl<$Res, $Val extends SyncStatusDto>
    implements $SyncStatusDtoCopyWith<$Res> {
  _$SyncStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? pendingChanges = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isSyncing: null == isSyncing
          ? _value.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pendingChanges: null == pendingChanges
          ? _value.pendingChanges
          : pendingChanges // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncStatusDtoImplCopyWith<$Res>
    implements $SyncStatusDtoCopyWith<$Res> {
  factory _$$SyncStatusDtoImplCopyWith(
          _$SyncStatusDtoImpl value, $Res Function(_$SyncStatusDtoImpl) then) =
      __$$SyncStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSyncing,
      DateTime? lastSyncTime,
      int pendingChanges,
      SyncStatus status,
      String? errorMessage});
}

/// @nodoc
class __$$SyncStatusDtoImplCopyWithImpl<$Res>
    extends _$SyncStatusDtoCopyWithImpl<$Res, _$SyncStatusDtoImpl>
    implements _$$SyncStatusDtoImplCopyWith<$Res> {
  __$$SyncStatusDtoImplCopyWithImpl(
      _$SyncStatusDtoImpl _value, $Res Function(_$SyncStatusDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? pendingChanges = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SyncStatusDtoImpl(
      isSyncing: null == isSyncing
          ? _value.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pendingChanges: null == pendingChanges
          ? _value.pendingChanges
          : pendingChanges // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncStatusDtoImpl implements _SyncStatusDto {
  const _$SyncStatusDtoImpl(
      {required this.isSyncing,
      required this.lastSyncTime,
      required this.pendingChanges,
      required this.status,
      this.errorMessage});

  factory _$SyncStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncStatusDtoImplFromJson(json);

  @override
  final bool isSyncing;
  @override
  final DateTime? lastSyncTime;
  @override
  final int pendingChanges;
  @override
  final SyncStatus status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SyncStatusDto(isSyncing: $isSyncing, lastSyncTime: $lastSyncTime, pendingChanges: $pendingChanges, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatusDtoImpl &&
            (identical(other.isSyncing, isSyncing) ||
                other.isSyncing == isSyncing) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.pendingChanges, pendingChanges) ||
                other.pendingChanges == pendingChanges) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isSyncing, lastSyncTime,
      pendingChanges, status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatusDtoImplCopyWith<_$SyncStatusDtoImpl> get copyWith =>
      __$$SyncStatusDtoImplCopyWithImpl<_$SyncStatusDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncStatusDtoImplToJson(
      this,
    );
  }
}

abstract class _SyncStatusDto implements SyncStatusDto {
  const factory _SyncStatusDto(
      {required final bool isSyncing,
      required final DateTime? lastSyncTime,
      required final int pendingChanges,
      required final SyncStatus status,
      final String? errorMessage}) = _$SyncStatusDtoImpl;

  factory _SyncStatusDto.fromJson(Map<String, dynamic> json) =
      _$SyncStatusDtoImpl.fromJson;

  @override
  bool get isSyncing;
  @override
  DateTime? get lastSyncTime;
  @override
  int get pendingChanges;
  @override
  SyncStatus get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatusDtoImplCopyWith<_$SyncStatusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConflictDto _$ConflictDtoFromJson(Map<String, dynamic> json) {
  return _ConflictDto.fromJson(json);
}

/// @nodoc
mixin _$ConflictDto {
  String get id => throw _privateConstructorUsedError;
  ConflictType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get localData => throw _privateConstructorUsedError;
  Map<String, dynamic> get remoteData => throw _privateConstructorUsedError;
  DateTime get localUpdatedAt => throw _privateConstructorUsedError;
  DateTime get remoteUpdatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConflictDtoCopyWith<ConflictDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictDtoCopyWith<$Res> {
  factory $ConflictDtoCopyWith(
          ConflictDto value, $Res Function(ConflictDto) then) =
      _$ConflictDtoCopyWithImpl<$Res, ConflictDto>;
  @useResult
  $Res call(
      {String id,
      ConflictType type,
      Map<String, dynamic> localData,
      Map<String, dynamic> remoteData,
      DateTime localUpdatedAt,
      DateTime remoteUpdatedAt});
}

/// @nodoc
class _$ConflictDtoCopyWithImpl<$Res, $Val extends ConflictDto>
    implements $ConflictDtoCopyWith<$Res> {
  _$ConflictDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? localData = null,
    Object? remoteData = null,
    Object? localUpdatedAt = null,
    Object? remoteUpdatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConflictType,
      localData: null == localData
          ? _value.localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      remoteData: null == remoteData
          ? _value.remoteData
          : remoteData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      localUpdatedAt: null == localUpdatedAt
          ? _value.localUpdatedAt
          : localUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      remoteUpdatedAt: null == remoteUpdatedAt
          ? _value.remoteUpdatedAt
          : remoteUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConflictDtoImplCopyWith<$Res>
    implements $ConflictDtoCopyWith<$Res> {
  factory _$$ConflictDtoImplCopyWith(
          _$ConflictDtoImpl value, $Res Function(_$ConflictDtoImpl) then) =
      __$$ConflictDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ConflictType type,
      Map<String, dynamic> localData,
      Map<String, dynamic> remoteData,
      DateTime localUpdatedAt,
      DateTime remoteUpdatedAt});
}

/// @nodoc
class __$$ConflictDtoImplCopyWithImpl<$Res>
    extends _$ConflictDtoCopyWithImpl<$Res, _$ConflictDtoImpl>
    implements _$$ConflictDtoImplCopyWith<$Res> {
  __$$ConflictDtoImplCopyWithImpl(
      _$ConflictDtoImpl _value, $Res Function(_$ConflictDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? localData = null,
    Object? remoteData = null,
    Object? localUpdatedAt = null,
    Object? remoteUpdatedAt = null,
  }) {
    return _then(_$ConflictDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ConflictType,
      localData: null == localData
          ? _value._localData
          : localData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      remoteData: null == remoteData
          ? _value._remoteData
          : remoteData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      localUpdatedAt: null == localUpdatedAt
          ? _value.localUpdatedAt
          : localUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      remoteUpdatedAt: null == remoteUpdatedAt
          ? _value.remoteUpdatedAt
          : remoteUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConflictDtoImpl implements _ConflictDto {
  const _$ConflictDtoImpl(
      {required this.id,
      required this.type,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> remoteData,
      required this.localUpdatedAt,
      required this.remoteUpdatedAt})
      : _localData = localData,
        _remoteData = remoteData;

  factory _$ConflictDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConflictDtoImplFromJson(json);

  @override
  final String id;
  @override
  final ConflictType type;
  final Map<String, dynamic> _localData;
  @override
  Map<String, dynamic> get localData {
    if (_localData is EqualUnmodifiableMapView) return _localData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_localData);
  }

  final Map<String, dynamic> _remoteData;
  @override
  Map<String, dynamic> get remoteData {
    if (_remoteData is EqualUnmodifiableMapView) return _remoteData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_remoteData);
  }

  @override
  final DateTime localUpdatedAt;
  @override
  final DateTime remoteUpdatedAt;

  @override
  String toString() {
    return 'ConflictDto(id: $id, type: $type, localData: $localData, remoteData: $remoteData, localUpdatedAt: $localUpdatedAt, remoteUpdatedAt: $remoteUpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._localData, _localData) &&
            const DeepCollectionEquality()
                .equals(other._remoteData, _remoteData) &&
            (identical(other.localUpdatedAt, localUpdatedAt) ||
                other.localUpdatedAt == localUpdatedAt) &&
            (identical(other.remoteUpdatedAt, remoteUpdatedAt) ||
                other.remoteUpdatedAt == remoteUpdatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      const DeepCollectionEquality().hash(_localData),
      const DeepCollectionEquality().hash(_remoteData),
      localUpdatedAt,
      remoteUpdatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictDtoImplCopyWith<_$ConflictDtoImpl> get copyWith =>
      __$$ConflictDtoImplCopyWithImpl<_$ConflictDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConflictDtoImplToJson(
      this,
    );
  }
}

abstract class _ConflictDto implements ConflictDto {
  const factory _ConflictDto(
      {required final String id,
      required final ConflictType type,
      required final Map<String, dynamic> localData,
      required final Map<String, dynamic> remoteData,
      required final DateTime localUpdatedAt,
      required final DateTime remoteUpdatedAt}) = _$ConflictDtoImpl;

  factory _ConflictDto.fromJson(Map<String, dynamic> json) =
      _$ConflictDtoImpl.fromJson;

  @override
  String get id;
  @override
  ConflictType get type;
  @override
  Map<String, dynamic> get localData;
  @override
  Map<String, dynamic> get remoteData;
  @override
  DateTime get localUpdatedAt;
  @override
  DateTime get remoteUpdatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ConflictDtoImplCopyWith<_$ConflictDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BatchSyncDto _$BatchSyncDtoFromJson(Map<String, dynamic> json) {
  return _BatchSyncDto.fromJson(json);
}

/// @nodoc
mixin _$BatchSyncDto {
  List<ExpenseModel> get expenses => throw _privateConstructorUsedError;
  List<BudgetModel> get budgets => throw _privateConstructorUsedError;
  List<String> get deletedIds => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BatchSyncDtoCopyWith<BatchSyncDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchSyncDtoCopyWith<$Res> {
  factory $BatchSyncDtoCopyWith(
          BatchSyncDto value, $Res Function(BatchSyncDto) then) =
      _$BatchSyncDtoCopyWithImpl<$Res, BatchSyncDto>;
  @useResult
  $Res call(
      {List<ExpenseModel> expenses,
      List<BudgetModel> budgets,
      List<String> deletedIds,
      String deviceId,
      DateTime timestamp});
}

/// @nodoc
class _$BatchSyncDtoCopyWithImpl<$Res, $Val extends BatchSyncDto>
    implements $BatchSyncDtoCopyWith<$Res> {
  _$BatchSyncDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
    Object? budgets = null,
    Object? deletedIds = null,
    Object? deviceId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      budgets: null == budgets
          ? _value.budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetModel>,
      deletedIds: null == deletedIds
          ? _value.deletedIds
          : deletedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BatchSyncDtoImplCopyWith<$Res>
    implements $BatchSyncDtoCopyWith<$Res> {
  factory _$$BatchSyncDtoImplCopyWith(
          _$BatchSyncDtoImpl value, $Res Function(_$BatchSyncDtoImpl) then) =
      __$$BatchSyncDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ExpenseModel> expenses,
      List<BudgetModel> budgets,
      List<String> deletedIds,
      String deviceId,
      DateTime timestamp});
}

/// @nodoc
class __$$BatchSyncDtoImplCopyWithImpl<$Res>
    extends _$BatchSyncDtoCopyWithImpl<$Res, _$BatchSyncDtoImpl>
    implements _$$BatchSyncDtoImplCopyWith<$Res> {
  __$$BatchSyncDtoImplCopyWithImpl(
      _$BatchSyncDtoImpl _value, $Res Function(_$BatchSyncDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
    Object? budgets = null,
    Object? deletedIds = null,
    Object? deviceId = null,
    Object? timestamp = null,
  }) {
    return _then(_$BatchSyncDtoImpl(
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
      budgets: null == budgets
          ? _value._budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetModel>,
      deletedIds: null == deletedIds
          ? _value._deletedIds
          : deletedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchSyncDtoImpl implements _BatchSyncDto {
  const _$BatchSyncDtoImpl(
      {required final List<ExpenseModel> expenses,
      required final List<BudgetModel> budgets,
      required final List<String> deletedIds,
      required this.deviceId,
      required this.timestamp})
      : _expenses = expenses,
        _budgets = budgets,
        _deletedIds = deletedIds;

  factory _$BatchSyncDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchSyncDtoImplFromJson(json);

  final List<ExpenseModel> _expenses;
  @override
  List<ExpenseModel> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  final List<BudgetModel> _budgets;
  @override
  List<BudgetModel> get budgets {
    if (_budgets is EqualUnmodifiableListView) return _budgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgets);
  }

  final List<String> _deletedIds;
  @override
  List<String> get deletedIds {
    if (_deletedIds is EqualUnmodifiableListView) return _deletedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedIds);
  }

  @override
  final String deviceId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'BatchSyncDto(expenses: $expenses, budgets: $budgets, deletedIds: $deletedIds, deviceId: $deviceId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchSyncDtoImpl &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            const DeepCollectionEquality().equals(other._budgets, _budgets) &&
            const DeepCollectionEquality()
                .equals(other._deletedIds, _deletedIds) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_expenses),
      const DeepCollectionEquality().hash(_budgets),
      const DeepCollectionEquality().hash(_deletedIds),
      deviceId,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchSyncDtoImplCopyWith<_$BatchSyncDtoImpl> get copyWith =>
      __$$BatchSyncDtoImplCopyWithImpl<_$BatchSyncDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchSyncDtoImplToJson(
      this,
    );
  }
}

abstract class _BatchSyncDto implements BatchSyncDto {
  const factory _BatchSyncDto(
      {required final List<ExpenseModel> expenses,
      required final List<BudgetModel> budgets,
      required final List<String> deletedIds,
      required final String deviceId,
      required final DateTime timestamp}) = _$BatchSyncDtoImpl;

  factory _BatchSyncDto.fromJson(Map<String, dynamic> json) =
      _$BatchSyncDtoImpl.fromJson;

  @override
  List<ExpenseModel> get expenses;
  @override
  List<BudgetModel> get budgets;
  @override
  List<String> get deletedIds;
  @override
  String get deviceId;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$BatchSyncDtoImplCopyWith<_$BatchSyncDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncLogDto _$SyncLogDtoFromJson(Map<String, dynamic> json) {
  return _SyncLogDto.fromJson(json);
}

/// @nodoc
mixin _$SyncLogDto {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  SyncStatus get status => throw _privateConstructorUsedError;
  int get itemsSynced => throw _privateConstructorUsedError;
  int get itemsFailed => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncLogDtoCopyWith<SyncLogDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncLogDtoCopyWith<$Res> {
  factory $SyncLogDtoCopyWith(
          SyncLogDto value, $Res Function(SyncLogDto) then) =
      _$SyncLogDtoCopyWithImpl<$Res, SyncLogDto>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      SyncStatus status,
      int itemsSynced,
      int itemsFailed,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$SyncLogDtoCopyWithImpl<$Res, $Val extends SyncLogDto>
    implements $SyncLogDtoCopyWith<$Res> {
  _$SyncLogDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? status = null,
    Object? itemsSynced = null,
    Object? itemsFailed = null,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsFailed: null == itemsFailed
          ? _value.itemsFailed
          : itemsFailed // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncLogDtoImplCopyWith<$Res>
    implements $SyncLogDtoCopyWith<$Res> {
  factory _$$SyncLogDtoImplCopyWith(
          _$SyncLogDtoImpl value, $Res Function(_$SyncLogDtoImpl) then) =
      __$$SyncLogDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      SyncStatus status,
      int itemsSynced,
      int itemsFailed,
      String? errorMessage,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$SyncLogDtoImplCopyWithImpl<$Res>
    extends _$SyncLogDtoCopyWithImpl<$Res, _$SyncLogDtoImpl>
    implements _$$SyncLogDtoImplCopyWith<$Res> {
  __$$SyncLogDtoImplCopyWithImpl(
      _$SyncLogDtoImpl _value, $Res Function(_$SyncLogDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? status = null,
    Object? itemsSynced = null,
    Object? itemsFailed = null,
    Object? errorMessage = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$SyncLogDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      itemsSynced: null == itemsSynced
          ? _value.itemsSynced
          : itemsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      itemsFailed: null == itemsFailed
          ? _value.itemsFailed
          : itemsFailed // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncLogDtoImpl implements _SyncLogDto {
  const _$SyncLogDtoImpl(
      {required this.id,
      required this.timestamp,
      required this.status,
      required this.itemsSynced,
      required this.itemsFailed,
      this.errorMessage,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$SyncLogDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncLogDtoImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final SyncStatus status;
  @override
  final int itemsSynced;
  @override
  final int itemsFailed;
  @override
  final String? errorMessage;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SyncLogDto(id: $id, timestamp: $timestamp, status: $status, itemsSynced: $itemsSynced, itemsFailed: $itemsFailed, errorMessage: $errorMessage, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncLogDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.itemsSynced, itemsSynced) ||
                other.itemsSynced == itemsSynced) &&
            (identical(other.itemsFailed, itemsFailed) ||
                other.itemsFailed == itemsFailed) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      status,
      itemsSynced,
      itemsFailed,
      errorMessage,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncLogDtoImplCopyWith<_$SyncLogDtoImpl> get copyWith =>
      __$$SyncLogDtoImplCopyWithImpl<_$SyncLogDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncLogDtoImplToJson(
      this,
    );
  }
}

abstract class _SyncLogDto implements SyncLogDto {
  const factory _SyncLogDto(
      {required final String id,
      required final DateTime timestamp,
      required final SyncStatus status,
      required final int itemsSynced,
      required final int itemsFailed,
      final String? errorMessage,
      final Map<String, dynamic>? metadata}) = _$SyncLogDtoImpl;

  factory _SyncLogDto.fromJson(Map<String, dynamic> json) =
      _$SyncLogDtoImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  SyncStatus get status;
  @override
  int get itemsSynced;
  @override
  int get itemsFailed;
  @override
  String? get errorMessage;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$SyncLogDtoImplCopyWith<_$SyncLogDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
