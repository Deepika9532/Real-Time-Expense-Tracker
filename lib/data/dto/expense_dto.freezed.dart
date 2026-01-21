// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateExpenseDto _$CreateExpenseDtoFromJson(Map<String, dynamic> json) {
  return _CreateExpenseDto.fromJson(json);
}

/// @nodoc
mixin _$CreateExpenseDto {
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get receipt => throw _privateConstructorUsedError;
  ExpenseType get type => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateExpenseDtoCopyWith<CreateExpenseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateExpenseDtoCopyWith<$Res> {
  factory $CreateExpenseDtoCopyWith(
          CreateExpenseDto value, $Res Function(CreateExpenseDto) then) =
      _$CreateExpenseDtoCopyWithImpl<$Res, CreateExpenseDto>;
  @useResult
  $Res call(
      {String title,
      double amount,
      String categoryId,
      DateTime date,
      String? description,
      String? receipt,
      ExpenseType type,
      String? paymentMethod,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$CreateExpenseDtoCopyWithImpl<$Res, $Val extends CreateExpenseDto>
    implements $CreateExpenseDtoCopyWith<$Res> {
  _$CreateExpenseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? categoryId = null,
    Object? date = null,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = null,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$CreateExpenseDtoImplCopyWith<$Res>
    implements $CreateExpenseDtoCopyWith<$Res> {
  factory _$$CreateExpenseDtoImplCopyWith(_$CreateExpenseDtoImpl value,
          $Res Function(_$CreateExpenseDtoImpl) then) =
      __$$CreateExpenseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      double amount,
      String categoryId,
      DateTime date,
      String? description,
      String? receipt,
      ExpenseType type,
      String? paymentMethod,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$CreateExpenseDtoImplCopyWithImpl<$Res>
    extends _$CreateExpenseDtoCopyWithImpl<$Res, _$CreateExpenseDtoImpl>
    implements _$$CreateExpenseDtoImplCopyWith<$Res> {
  __$$CreateExpenseDtoImplCopyWithImpl(_$CreateExpenseDtoImpl _value,
      $Res Function(_$CreateExpenseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? categoryId = null,
    Object? date = null,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = null,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$CreateExpenseDtoImpl(
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
class _$CreateExpenseDtoImpl implements _CreateExpenseDto {
  const _$CreateExpenseDtoImpl(
      {required this.title,
      required this.amount,
      required this.categoryId,
      required this.date,
      this.description,
      this.receipt,
      this.type = ExpenseType.expense,
      this.paymentMethod,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$CreateExpenseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateExpenseDtoImplFromJson(json);

  @override
  final String title;
  @override
  final double amount;
  @override
  final String categoryId;
  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final String? receipt;
  @override
  @JsonKey()
  final ExpenseType type;
  @override
  final String? paymentMethod;
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
    return 'CreateExpenseDto(title: $title, amount: $amount, categoryId: $categoryId, date: $date, description: $description, receipt: $receipt, type: $type, paymentMethod: $paymentMethod, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExpenseDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      amount,
      categoryId,
      date,
      description,
      receipt,
      type,
      paymentMethod,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateExpenseDtoImplCopyWith<_$CreateExpenseDtoImpl> get copyWith =>
      __$$CreateExpenseDtoImplCopyWithImpl<_$CreateExpenseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateExpenseDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateExpenseDto implements CreateExpenseDto {
  const factory _CreateExpenseDto(
      {required final String title,
      required final double amount,
      required final String categoryId,
      required final DateTime date,
      final String? description,
      final String? receipt,
      final ExpenseType type,
      final String? paymentMethod,
      final Map<String, dynamic>? metadata}) = _$CreateExpenseDtoImpl;

  factory _CreateExpenseDto.fromJson(Map<String, dynamic> json) =
      _$CreateExpenseDtoImpl.fromJson;

  @override
  String get title;
  @override
  double get amount;
  @override
  String get categoryId;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  String? get receipt;
  @override
  ExpenseType get type;
  @override
  String? get paymentMethod;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$CreateExpenseDtoImplCopyWith<_$CreateExpenseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateExpenseDto _$UpdateExpenseDtoFromJson(Map<String, dynamic> json) {
  return _UpdateExpenseDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateExpenseDto {
  String? get title => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get receipt => throw _privateConstructorUsedError;
  ExpenseType? get type => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateExpenseDtoCopyWith<UpdateExpenseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateExpenseDtoCopyWith<$Res> {
  factory $UpdateExpenseDtoCopyWith(
          UpdateExpenseDto value, $Res Function(UpdateExpenseDto) then) =
      _$UpdateExpenseDtoCopyWithImpl<$Res, UpdateExpenseDto>;
  @useResult
  $Res call(
      {String? title,
      double? amount,
      String? categoryId,
      DateTime? date,
      String? description,
      String? receipt,
      ExpenseType? type,
      String? paymentMethod,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$UpdateExpenseDtoCopyWithImpl<$Res, $Val extends UpdateExpenseDto>
    implements $UpdateExpenseDtoCopyWith<$Res> {
  _$UpdateExpenseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? amount = freezed,
    Object? categoryId = freezed,
    Object? date = freezed,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
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
abstract class _$$UpdateExpenseDtoImplCopyWith<$Res>
    implements $UpdateExpenseDtoCopyWith<$Res> {
  factory _$$UpdateExpenseDtoImplCopyWith(_$UpdateExpenseDtoImpl value,
          $Res Function(_$UpdateExpenseDtoImpl) then) =
      __$$UpdateExpenseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      double? amount,
      String? categoryId,
      DateTime? date,
      String? description,
      String? receipt,
      ExpenseType? type,
      String? paymentMethod,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$UpdateExpenseDtoImplCopyWithImpl<$Res>
    extends _$UpdateExpenseDtoCopyWithImpl<$Res, _$UpdateExpenseDtoImpl>
    implements _$$UpdateExpenseDtoImplCopyWith<$Res> {
  __$$UpdateExpenseDtoImplCopyWithImpl(_$UpdateExpenseDtoImpl _value,
      $Res Function(_$UpdateExpenseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? amount = freezed,
    Object? categoryId = freezed,
    Object? date = freezed,
    Object? description = freezed,
    Object? receipt = freezed,
    Object? type = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$UpdateExpenseDtoImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
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
class _$UpdateExpenseDtoImpl implements _UpdateExpenseDto {
  const _$UpdateExpenseDtoImpl(
      {this.title,
      this.amount,
      this.categoryId,
      this.date,
      this.description,
      this.receipt,
      this.type,
      this.paymentMethod,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$UpdateExpenseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateExpenseDtoImplFromJson(json);

  @override
  final String? title;
  @override
  final double? amount;
  @override
  final String? categoryId;
  @override
  final DateTime? date;
  @override
  final String? description;
  @override
  final String? receipt;
  @override
  final ExpenseType? type;
  @override
  final String? paymentMethod;
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
    return 'UpdateExpenseDto(title: $title, amount: $amount, categoryId: $categoryId, date: $date, description: $description, receipt: $receipt, type: $type, paymentMethod: $paymentMethod, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateExpenseDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      amount,
      categoryId,
      date,
      description,
      receipt,
      type,
      paymentMethod,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateExpenseDtoImplCopyWith<_$UpdateExpenseDtoImpl> get copyWith =>
      __$$UpdateExpenseDtoImplCopyWithImpl<_$UpdateExpenseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateExpenseDtoImplToJson(
      this,
    );
  }
}

abstract class _UpdateExpenseDto implements UpdateExpenseDto {
  const factory _UpdateExpenseDto(
      {final String? title,
      final double? amount,
      final String? categoryId,
      final DateTime? date,
      final String? description,
      final String? receipt,
      final ExpenseType? type,
      final String? paymentMethod,
      final Map<String, dynamic>? metadata}) = _$UpdateExpenseDtoImpl;

  factory _UpdateExpenseDto.fromJson(Map<String, dynamic> json) =
      _$UpdateExpenseDtoImpl.fromJson;

  @override
  String? get title;
  @override
  double? get amount;
  @override
  String? get categoryId;
  @override
  DateTime? get date;
  @override
  String? get description;
  @override
  String? get receipt;
  @override
  ExpenseType? get type;
  @override
  String? get paymentMethod;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$UpdateExpenseDtoImplCopyWith<_$UpdateExpenseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpenseFilterDto _$ExpenseFilterDtoFromJson(Map<String, dynamic> json) {
  return _ExpenseFilterDto.fromJson(json);
}

/// @nodoc
mixin _$ExpenseFilterDto {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  ExpenseType? get type => throw _privateConstructorUsedError;
  double? get minAmount => throw _privateConstructorUsedError;
  double? get maxAmount => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  ExpenseSortField? get sortBy => throw _privateConstructorUsedError;
  SortOrder get sortOrder => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseFilterDtoCopyWith<ExpenseFilterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseFilterDtoCopyWith<$Res> {
  factory $ExpenseFilterDtoCopyWith(
          ExpenseFilterDto value, $Res Function(ExpenseFilterDto) then) =
      _$ExpenseFilterDtoCopyWithImpl<$Res, ExpenseFilterDto>;
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      String? categoryId,
      ExpenseType? type,
      double? minAmount,
      double? maxAmount,
      String? searchQuery,
      ExpenseSortField? sortBy,
      SortOrder sortOrder,
      int page,
      int limit});
}

/// @nodoc
class _$ExpenseFilterDtoCopyWithImpl<$Res, $Val extends ExpenseFilterDto>
    implements $ExpenseFilterDtoCopyWith<$Res> {
  _$ExpenseFilterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? categoryId = freezed,
    Object? type = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = null,
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as ExpenseSortField?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseFilterDtoImplCopyWith<$Res>
    implements $ExpenseFilterDtoCopyWith<$Res> {
  factory _$$ExpenseFilterDtoImplCopyWith(_$ExpenseFilterDtoImpl value,
          $Res Function(_$ExpenseFilterDtoImpl) then) =
      __$$ExpenseFilterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      String? categoryId,
      ExpenseType? type,
      double? minAmount,
      double? maxAmount,
      String? searchQuery,
      ExpenseSortField? sortBy,
      SortOrder sortOrder,
      int page,
      int limit});
}

/// @nodoc
class __$$ExpenseFilterDtoImplCopyWithImpl<$Res>
    extends _$ExpenseFilterDtoCopyWithImpl<$Res, _$ExpenseFilterDtoImpl>
    implements _$$ExpenseFilterDtoImplCopyWith<$Res> {
  __$$ExpenseFilterDtoImplCopyWithImpl(_$ExpenseFilterDtoImpl _value,
      $Res Function(_$ExpenseFilterDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? categoryId = freezed,
    Object? type = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = null,
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_$ExpenseFilterDtoImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as ExpenseSortField?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseFilterDtoImpl implements _ExpenseFilterDto {
  const _$ExpenseFilterDtoImpl(
      {this.startDate,
      this.endDate,
      this.categoryId,
      this.type,
      this.minAmount,
      this.maxAmount,
      this.searchQuery,
      this.sortBy,
      this.sortOrder = SortOrder.descending,
      this.page = 0,
      this.limit = 20});

  factory _$ExpenseFilterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseFilterDtoImplFromJson(json);

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? categoryId;
  @override
  final ExpenseType? type;
  @override
  final double? minAmount;
  @override
  final double? maxAmount;
  @override
  final String? searchQuery;
  @override
  final ExpenseSortField? sortBy;
  @override
  @JsonKey()
  final SortOrder sortOrder;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'ExpenseFilterDto(startDate: $startDate, endDate: $endDate, categoryId: $categoryId, type: $type, minAmount: $minAmount, maxAmount: $maxAmount, searchQuery: $searchQuery, sortBy: $sortBy, sortOrder: $sortOrder, page: $page, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseFilterDtoImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate, categoryId,
      type, minAmount, maxAmount, searchQuery, sortBy, sortOrder, page, limit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseFilterDtoImplCopyWith<_$ExpenseFilterDtoImpl> get copyWith =>
      __$$ExpenseFilterDtoImplCopyWithImpl<_$ExpenseFilterDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseFilterDtoImplToJson(
      this,
    );
  }
}

abstract class _ExpenseFilterDto implements ExpenseFilterDto {
  const factory _ExpenseFilterDto(
      {final DateTime? startDate,
      final DateTime? endDate,
      final String? categoryId,
      final ExpenseType? type,
      final double? minAmount,
      final double? maxAmount,
      final String? searchQuery,
      final ExpenseSortField? sortBy,
      final SortOrder sortOrder,
      final int page,
      final int limit}) = _$ExpenseFilterDtoImpl;

  factory _ExpenseFilterDto.fromJson(Map<String, dynamic> json) =
      _$ExpenseFilterDtoImpl.fromJson;

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get categoryId;
  @override
  ExpenseType? get type;
  @override
  double? get minAmount;
  @override
  double? get maxAmount;
  @override
  String? get searchQuery;
  @override
  ExpenseSortField? get sortBy;
  @override
  SortOrder get sortOrder;
  @override
  int get page;
  @override
  int get limit;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseFilterDtoImplCopyWith<_$ExpenseFilterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpenseStatsDto _$ExpenseStatsDtoFromJson(Map<String, dynamic> json) {
  return _ExpenseStatsDto.fromJson(json);
}

/// @nodoc
mixin _$ExpenseStatsDto {
  double get totalExpense => throw _privateConstructorUsedError;
  double get totalIncome => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  Map<String, double> get categoryBreakdown =>
      throw _privateConstructorUsedError;
  Map<String, double> get monthlyTrend => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseStatsDtoCopyWith<ExpenseStatsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseStatsDtoCopyWith<$Res> {
  factory $ExpenseStatsDtoCopyWith(
          ExpenseStatsDto value, $Res Function(ExpenseStatsDto) then) =
      _$ExpenseStatsDtoCopyWithImpl<$Res, ExpenseStatsDto>;
  @useResult
  $Res call(
      {double totalExpense,
      double totalIncome,
      double balance,
      int transactionCount,
      Map<String, double> categoryBreakdown,
      Map<String, double> monthlyTrend,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class _$ExpenseStatsDtoCopyWithImpl<$Res, $Val extends ExpenseStatsDto>
    implements $ExpenseStatsDtoCopyWith<$Res> {
  _$ExpenseStatsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalExpense = null,
    Object? totalIncome = null,
    Object? balance = null,
    Object? transactionCount = null,
    Object? categoryBreakdown = null,
    Object? monthlyTrend = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as double,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      categoryBreakdown: null == categoryBreakdown
          ? _value.categoryBreakdown
          : categoryBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      monthlyTrend: null == monthlyTrend
          ? _value.monthlyTrend
          : monthlyTrend // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseStatsDtoImplCopyWith<$Res>
    implements $ExpenseStatsDtoCopyWith<$Res> {
  factory _$$ExpenseStatsDtoImplCopyWith(_$ExpenseStatsDtoImpl value,
          $Res Function(_$ExpenseStatsDtoImpl) then) =
      __$$ExpenseStatsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalExpense,
      double totalIncome,
      double balance,
      int transactionCount,
      Map<String, double> categoryBreakdown,
      Map<String, double> monthlyTrend,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$ExpenseStatsDtoImplCopyWithImpl<$Res>
    extends _$ExpenseStatsDtoCopyWithImpl<$Res, _$ExpenseStatsDtoImpl>
    implements _$$ExpenseStatsDtoImplCopyWith<$Res> {
  __$$ExpenseStatsDtoImplCopyWithImpl(
      _$ExpenseStatsDtoImpl _value, $Res Function(_$ExpenseStatsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalExpense = null,
    Object? totalIncome = null,
    Object? balance = null,
    Object? transactionCount = null,
    Object? categoryBreakdown = null,
    Object? monthlyTrend = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$ExpenseStatsDtoImpl(
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as double,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      categoryBreakdown: null == categoryBreakdown
          ? _value._categoryBreakdown
          : categoryBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      monthlyTrend: null == monthlyTrend
          ? _value._monthlyTrend
          : monthlyTrend // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseStatsDtoImpl implements _ExpenseStatsDto {
  const _$ExpenseStatsDtoImpl(
      {required this.totalExpense,
      required this.totalIncome,
      required this.balance,
      required this.transactionCount,
      required final Map<String, double> categoryBreakdown,
      required final Map<String, double> monthlyTrend,
      this.startDate,
      this.endDate})
      : _categoryBreakdown = categoryBreakdown,
        _monthlyTrend = monthlyTrend;

  factory _$ExpenseStatsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseStatsDtoImplFromJson(json);

  @override
  final double totalExpense;
  @override
  final double totalIncome;
  @override
  final double balance;
  @override
  final int transactionCount;
  final Map<String, double> _categoryBreakdown;
  @override
  Map<String, double> get categoryBreakdown {
    if (_categoryBreakdown is EqualUnmodifiableMapView)
      return _categoryBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryBreakdown);
  }

  final Map<String, double> _monthlyTrend;
  @override
  Map<String, double> get monthlyTrend {
    if (_monthlyTrend is EqualUnmodifiableMapView) return _monthlyTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_monthlyTrend);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'ExpenseStatsDto(totalExpense: $totalExpense, totalIncome: $totalIncome, balance: $balance, transactionCount: $transactionCount, categoryBreakdown: $categoryBreakdown, monthlyTrend: $monthlyTrend, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseStatsDtoImpl &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            const DeepCollectionEquality()
                .equals(other._categoryBreakdown, _categoryBreakdown) &&
            const DeepCollectionEquality()
                .equals(other._monthlyTrend, _monthlyTrend) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalExpense,
      totalIncome,
      balance,
      transactionCount,
      const DeepCollectionEquality().hash(_categoryBreakdown),
      const DeepCollectionEquality().hash(_monthlyTrend),
      startDate,
      endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseStatsDtoImplCopyWith<_$ExpenseStatsDtoImpl> get copyWith =>
      __$$ExpenseStatsDtoImplCopyWithImpl<_$ExpenseStatsDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseStatsDtoImplToJson(
      this,
    );
  }
}

abstract class _ExpenseStatsDto implements ExpenseStatsDto {
  const factory _ExpenseStatsDto(
      {required final double totalExpense,
      required final double totalIncome,
      required final double balance,
      required final int transactionCount,
      required final Map<String, double> categoryBreakdown,
      required final Map<String, double> monthlyTrend,
      final DateTime? startDate,
      final DateTime? endDate}) = _$ExpenseStatsDtoImpl;

  factory _ExpenseStatsDto.fromJson(Map<String, dynamic> json) =
      _$ExpenseStatsDtoImpl.fromJson;

  @override
  double get totalExpense;
  @override
  double get totalIncome;
  @override
  double get balance;
  @override
  int get transactionCount;
  @override
  Map<String, double> get categoryBreakdown;
  @override
  Map<String, double> get monthlyTrend;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseStatsDtoImplCopyWith<_$ExpenseStatsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkExpenseDto _$BulkExpenseDtoFromJson(Map<String, dynamic> json) {
  return _BulkExpenseDto.fromJson(json);
}

/// @nodoc
mixin _$BulkExpenseDto {
  List<String> get expenseIds => throw _privateConstructorUsedError;
  BulkOperation get operation => throw _privateConstructorUsedError;
  Map<String, dynamic>? get operationData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkExpenseDtoCopyWith<BulkExpenseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkExpenseDtoCopyWith<$Res> {
  factory $BulkExpenseDtoCopyWith(
          BulkExpenseDto value, $Res Function(BulkExpenseDto) then) =
      _$BulkExpenseDtoCopyWithImpl<$Res, BulkExpenseDto>;
  @useResult
  $Res call(
      {List<String> expenseIds,
      BulkOperation operation,
      Map<String, dynamic>? operationData});
}

/// @nodoc
class _$BulkExpenseDtoCopyWithImpl<$Res, $Val extends BulkExpenseDto>
    implements $BulkExpenseDtoCopyWith<$Res> {
  _$BulkExpenseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseIds = null,
    Object? operation = null,
    Object? operationData = freezed,
  }) {
    return _then(_value.copyWith(
      expenseIds: null == expenseIds
          ? _value.expenseIds
          : expenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as BulkOperation,
      operationData: freezed == operationData
          ? _value.operationData
          : operationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkExpenseDtoImplCopyWith<$Res>
    implements $BulkExpenseDtoCopyWith<$Res> {
  factory _$$BulkExpenseDtoImplCopyWith(_$BulkExpenseDtoImpl value,
          $Res Function(_$BulkExpenseDtoImpl) then) =
      __$$BulkExpenseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> expenseIds,
      BulkOperation operation,
      Map<String, dynamic>? operationData});
}

/// @nodoc
class __$$BulkExpenseDtoImplCopyWithImpl<$Res>
    extends _$BulkExpenseDtoCopyWithImpl<$Res, _$BulkExpenseDtoImpl>
    implements _$$BulkExpenseDtoImplCopyWith<$Res> {
  __$$BulkExpenseDtoImplCopyWithImpl(
      _$BulkExpenseDtoImpl _value, $Res Function(_$BulkExpenseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseIds = null,
    Object? operation = null,
    Object? operationData = freezed,
  }) {
    return _then(_$BulkExpenseDtoImpl(
      expenseIds: null == expenseIds
          ? _value._expenseIds
          : expenseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as BulkOperation,
      operationData: freezed == operationData
          ? _value._operationData
          : operationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkExpenseDtoImpl implements _BulkExpenseDto {
  const _$BulkExpenseDtoImpl(
      {required final List<String> expenseIds,
      required this.operation,
      final Map<String, dynamic>? operationData})
      : _expenseIds = expenseIds,
        _operationData = operationData;

  factory _$BulkExpenseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkExpenseDtoImplFromJson(json);

  final List<String> _expenseIds;
  @override
  List<String> get expenseIds {
    if (_expenseIds is EqualUnmodifiableListView) return _expenseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenseIds);
  }

  @override
  final BulkOperation operation;
  final Map<String, dynamic>? _operationData;
  @override
  Map<String, dynamic>? get operationData {
    final value = _operationData;
    if (value == null) return null;
    if (_operationData is EqualUnmodifiableMapView) return _operationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BulkExpenseDto(expenseIds: $expenseIds, operation: $operation, operationData: $operationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkExpenseDtoImpl &&
            const DeepCollectionEquality()
                .equals(other._expenseIds, _expenseIds) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            const DeepCollectionEquality()
                .equals(other._operationData, _operationData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_expenseIds),
      operation,
      const DeepCollectionEquality().hash(_operationData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkExpenseDtoImplCopyWith<_$BulkExpenseDtoImpl> get copyWith =>
      __$$BulkExpenseDtoImplCopyWithImpl<_$BulkExpenseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkExpenseDtoImplToJson(
      this,
    );
  }
}

abstract class _BulkExpenseDto implements BulkExpenseDto {
  const factory _BulkExpenseDto(
      {required final List<String> expenseIds,
      required final BulkOperation operation,
      final Map<String, dynamic>? operationData}) = _$BulkExpenseDtoImpl;

  factory _BulkExpenseDto.fromJson(Map<String, dynamic> json) =
      _$BulkExpenseDtoImpl.fromJson;

  @override
  List<String> get expenseIds;
  @override
  BulkOperation get operation;
  @override
  Map<String, dynamic>? get operationData;
  @override
  @JsonKey(ignore: true)
  _$$BulkExpenseDtoImplCopyWith<_$BulkExpenseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
