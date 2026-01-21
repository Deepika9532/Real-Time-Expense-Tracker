import '../models/expense_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseModel>> fetchExpenses();
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  @override
  Future<List<ExpenseModel>> fetchExpenses() async {
    return [];
  }
}
