import 'package:flutter/material.dart';

import '../../../../../core/utils/currency_formatter.dart';
import '../../../../domain/entities/budget.dart';

class BudgetProgress extends StatelessWidget {
  final Budget budget;

  const BudgetProgress({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    final spent = budget.spent;
    final remaining = (budget.amount - spent).clamp(0.0, double.infinity);
    final progress = (spent / budget.amount).clamp(0.0, 1.0);
    final isOverBudget = spent > budget.amount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spent',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  CurrencyFormatter.formatUSD(spent),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOverBudget ? Colors.red : Colors.orange,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isOverBudget ? 'Over Budget' : 'Remaining',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  isOverBudget
                      ? CurrencyFormatter.formatUSD(spent - budget.amount)
                      : CurrencyFormatter.formatUSD(remaining),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOverBudget ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Progress Bar
        Stack(
          children: [
            // Background
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            // Progress
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _getProgressColors(progress, isOverBudget),
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: _getProgressColor(
                        progress,
                        isOverBudget,
                      ).withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Progress Percentage
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(progress * 100).toStringAsFixed(1)}% used',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              CurrencyFormatter.formatUSD(budget.amount),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getProgressColor(double progress, bool isOverBudget) {
    if (isOverBudget) return Colors.red;
    if (progress >= 0.8) return Colors.orange;
    if (progress >= 0.5) return Colors.yellow[700]!;
    return Colors.green;
  }

  List<Color> _getProgressColors(double progress, bool isOverBudget) {
    final color = _getProgressColor(progress, isOverBudget);
    return [color, color.withOpacity(0.7)];
  }
}
