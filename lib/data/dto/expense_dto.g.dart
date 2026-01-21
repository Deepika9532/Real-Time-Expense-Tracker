// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateExpenseDtoImpl _$$CreateExpenseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateExpenseDtoImpl(
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      receipt: json['receipt'] as String?,
      type: $enumDecodeNullable(_$ExpenseTypeEnumMap, json['type']) ??
          ExpenseType.expense,
      paymentMethod: json['paymentMethod'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CreateExpenseDtoImplToJson(
        _$CreateExpenseDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'amount': instance.amount,
      'categoryId': instance.categoryId,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'receipt': instance.receipt,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
      'paymentMethod': instance.paymentMethod,
      'metadata': instance.metadata,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.expense: 'expense',
  ExpenseType.income: 'income',
};

_$UpdateExpenseDtoImpl _$$UpdateExpenseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateExpenseDtoImpl(
      title: json['title'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      categoryId: json['categoryId'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      receipt: json['receipt'] as String?,
      type: $enumDecodeNullable(_$ExpenseTypeEnumMap, json['type']),
      paymentMethod: json['paymentMethod'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UpdateExpenseDtoImplToJson(
        _$UpdateExpenseDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'amount': instance.amount,
      'categoryId': instance.categoryId,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'receipt': instance.receipt,
      'type': _$ExpenseTypeEnumMap[instance.type],
      'paymentMethod': instance.paymentMethod,
      'metadata': instance.metadata,
    };

_$ExpenseFilterDtoImpl _$$ExpenseFilterDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpenseFilterDtoImpl(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      categoryId: json['categoryId'] as String?,
      type: $enumDecodeNullable(_$ExpenseTypeEnumMap, json['type']),
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      searchQuery: json['searchQuery'] as String?,
      sortBy: $enumDecodeNullable(_$ExpenseSortFieldEnumMap, json['sortBy']),
      sortOrder: $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']) ??
          SortOrder.descending,
      page: (json['page'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$$ExpenseFilterDtoImplToJson(
        _$ExpenseFilterDtoImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'categoryId': instance.categoryId,
      'type': _$ExpenseTypeEnumMap[instance.type],
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'searchQuery': instance.searchQuery,
      'sortBy': _$ExpenseSortFieldEnumMap[instance.sortBy],
      'sortOrder': _$SortOrderEnumMap[instance.sortOrder]!,
      'page': instance.page,
      'limit': instance.limit,
    };

const _$ExpenseSortFieldEnumMap = {
  ExpenseSortField.date: 'date',
  ExpenseSortField.amount: 'amount',
  ExpenseSortField.title: 'title',
  ExpenseSortField.category: 'category',
  ExpenseSortField.createdAt: 'createdAt',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ascending',
  SortOrder.descending: 'descending',
};

_$ExpenseStatsDtoImpl _$$ExpenseStatsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpenseStatsDtoImpl(
      totalExpense: (json['totalExpense'] as num).toDouble(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      transactionCount: (json['transactionCount'] as num).toInt(),
      categoryBreakdown:
          (json['categoryBreakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      monthlyTrend: (json['monthlyTrend'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$ExpenseStatsDtoImplToJson(
        _$ExpenseStatsDtoImpl instance) =>
    <String, dynamic>{
      'totalExpense': instance.totalExpense,
      'totalIncome': instance.totalIncome,
      'balance': instance.balance,
      'transactionCount': instance.transactionCount,
      'categoryBreakdown': instance.categoryBreakdown,
      'monthlyTrend': instance.monthlyTrend,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };

_$BulkExpenseDtoImpl _$$BulkExpenseDtoImplFromJson(Map<String, dynamic> json) =>
    _$BulkExpenseDtoImpl(
      expenseIds: (json['expenseIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      operation: $enumDecode(_$BulkOperationEnumMap, json['operation']),
      operationData: json['operationData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BulkExpenseDtoImplToJson(
        _$BulkExpenseDtoImpl instance) =>
    <String, dynamic>{
      'expenseIds': instance.expenseIds,
      'operation': _$BulkOperationEnumMap[instance.operation]!,
      'operationData': instance.operationData,
    };

const _$BulkOperationEnumMap = {
  BulkOperation.delete: 'delete',
  BulkOperation.updateCategory: 'updateCategory',
  BulkOperation.export: 'export',
  BulkOperation.archive: 'archive',
};
