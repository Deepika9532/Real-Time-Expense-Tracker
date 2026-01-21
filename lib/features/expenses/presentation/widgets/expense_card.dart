// lib/features/expenses/presentation/widgets/expense_card.dart

import 'package:flutter/material.dart';

import '../../domain/entities/expense_entity.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseEntity expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(expense.category),
        trailing: Text('₹${expense.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
