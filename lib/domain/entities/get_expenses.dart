// lib/domain/usecases/get_expenses.dart
import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpensesByDateRangeParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const GetExpensesByDateRangeParams({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

class GetExpensesByCategoryParams extends Equatable {
  final String categoryId;

  const GetExpensesByCategoryParams({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
