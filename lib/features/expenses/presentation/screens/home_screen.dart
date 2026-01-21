// lib/features/expenses/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';

import '../providers/expense_provider.dart';
import '../widgets/expense_card.dart';

class HomeScreen extends StatelessWidget {
  final ExpenseProvider provider;

  const HomeScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: provider.expenses.isEmpty
          ? const Center(child: Text('No expenses yet'))
          : ListView.builder(
              itemCount: provider.expenses.length,
              itemBuilder: (context, index) {
                final expense = provider.expenses[index];
                return ExpenseCard(expense: expense);
              },
            ),
    );
  }
}
