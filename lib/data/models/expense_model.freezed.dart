// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) {
  return _ExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  double get amount => throw _privateConstructorUsedError;
  @HiveField(3)
  String get categoryId => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get receipt => throw _privateConstructorUsedError;
  @HiveField(7)
  ExpenseType get type => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get userId => throw _privateConstructorUsedError;
  @HiveField(9)
  bool get isSynced => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get paymentMethod => throw _privateConstructorUsedError;
  @HiveField(13)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res, ExpenseModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) double amount,
      @HiveField(3) String categoryId,
      @HiveField(4) DateTime date,
      @HiveField(5) String? description,
      @HiveField(6) String? receipt,
      @HiveField(7) ExpenseType type,
      @HiveField(8) String? userId,
      @HiveField(9) bool isSynced,
      @HiveField(10) DateTime? createdAt,
      @HiveField(11) DateTime? updatedAt,
      @HiveField(12) String? paymentMethod,
      @HiveField(13) Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res, $Val extends ExpenseModel>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? categoryId = null,
    Object? date = null,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = null,
    Object? userId = freezed,
    Object? isSynced = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseModelImplCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$ExpenseModelImplCopyWith(
          _$ExpenseModelImpl value, $Res Function(_$ExpenseModelImpl) then) =
      __$$ExpenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) double amount,
      @HiveField(3) String categoryId,
      @HiveField(4) DateTime date,
      @HiveField(5) String? description,
      @HiveField(6) String? receipt,
      @HiveField(7) ExpenseType type,
      @HiveField(8) String? userId,
      @HiveField(9) bool isSynced,
      @HiveField(10) DateTime? createdAt,
      @HiveField(11) DateTime? updatedAt,
      @HiveField(12) String? paymentMethod,
      @HiveField(13) Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ExpenseModelImplCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res, _$ExpenseModelImpl>
    implements _$$ExpenseModelImplCopyWith<$Res> {
  __$$ExpenseModelImplCopyWithImpl(
      _$ExpenseModelImpl _value, $Res Function(_$ExpenseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? categoryId = null,
    Object? date = null,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = null,
    Object? userId = freezed,
    Object? isSynced = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ExpenseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
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
class _$ExpenseModelImpl implements _ExpenseModel {
  const _$ExpenseModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.amount,
      @HiveField(3) required this.categoryId,
      @HiveField(4) required this.date,
      @HiveField(5) this.description,
      @HiveField(6) this.receipt,
      @HiveField(7) this.type = ExpenseType.expense,
      @HiveField(8) this.userId,
      @HiveField(9) this.isSynced = false,
      @HiveField(10) this.createdAt,
      @HiveField(11) this.updatedAt,
      @HiveField(12) this.paymentMethod,
      @HiveField(13) final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$ExpenseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final double amount;
  @override
  @HiveField(3)
  final String categoryId;
  @override
  @HiveField(4)
  final DateTime date;
  @override
  @HiveField(5)
  final String? description;
  @override
  @HiveField(6)
  final String? receipt;
  @override
  @JsonKey()
  @HiveField(7)
  final ExpenseType type;
  @override
  @HiveField(8)
  final String? userId;
  @override
  @JsonKey()
  @HiveField(9)
  final bool isSynced;
  @override
  @HiveField(10)
  final DateTime? createdAt;
  @override
  @HiveField(11)
  final DateTime? updatedAt;
  @override
  @HiveField(12)
  final String? paymentMethod;
  final Map<String, dynamic>? _metadata;
  @override
  @HiveField(13)
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ExpenseModel(id: $id, title: $title, amount: $amount, categoryId: $categoryId, date: $date, description: $description, receipt: $receipt, type: $type, userId: $userId, isSynced: $isSynced, createdAt: $createdAt, updatedAt: $updatedAt, paymentMethod: $paymentMethod, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      amount,
      categoryId,
      date,
      description,
      receipt,
      type,
      userId,
      isSynced,
      createdAt,
      updatedAt,
      paymentMethod,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      __$$ExpenseModelImplCopyWithImpl<_$ExpenseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseModelImplToJson(
      this,
    );
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  const factory _ExpenseModel(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String title,
          @HiveField(2) required final double amount,
          @HiveField(3) required final String categoryId,
          @HiveField(4) required final DateTime date,
          @HiveField(5) final String? description,
          @HiveField(6) final String? receipt,
          @HiveField(7) final ExpenseType type,
          @HiveField(8) final String? userId,
          @HiveField(9) final bool isSynced,
          @HiveField(10) final DateTime? createdAt,
          @HiveField(11) final DateTime? updatedAt,
          @HiveField(12) final String? paymentMethod,
          @HiveField(13) final Map<String, dynamic>? metadata}) =
      _$ExpenseModelImpl;

  factory _ExpenseModel.fromJson(Map<String, dynamic> json) =
      _$ExpenseModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  double get amount;
  @override
  @HiveField(3)
  String get categoryId;
  @override
  @HiveField(4)
  DateTime get date;
  @override
  @HiveField(5)
  String? get description;
  @override
  @HiveField(6)
  String? get receipt;
  @override
  @HiveField(7)
  ExpenseType get type;
  @override
  @HiveField(8)
  String? get userId;
  @override
  @HiveField(9)
  bool get isSynced;
  @override
  @HiveField(10)
  DateTime? get createdAt;
  @override
  @HiveField(11)
  DateTime? get updatedAt;
  @override
  @HiveField(12)
  String? get paymentMethod;
  @override
  @HiveField(13)
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
