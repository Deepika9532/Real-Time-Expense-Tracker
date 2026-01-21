import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../domain/entities/expense.dart';
import '../widgets/expense_card.dart';

class RecentTransactions extends StatelessWidget {
  final List<Expense> expenses;

  const RecentTransactions({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final expense = expenses[index];
        return ExpenseCard(
          expense: expense,
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.itemDetailRoute(expense.id));
          },
          onLongPress: () {
            _showExpenseOptions(context, expense);
          },
        );
      }, childCount: expenses.length),
    );
  }

  void _showExpenseOptions(BuildContext context, Expense expense) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.itemEditRoute(expense.id));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, expense);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                // Implement share functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text('Are you sure you want to delete "${expense.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete expense
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaction deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
