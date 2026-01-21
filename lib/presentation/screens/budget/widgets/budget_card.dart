import 'package:flutter/material.dart';

import '../../../../domain/entities/budget.dart';
import 'budget_progress.dart';

class BudgetCard extends StatelessWidget {
  final Budget budget;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const BudgetCard({
    super.key,
    required this.budget,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final spent = budget.spent;
    final isOverBudget = spent > budget.amount;
    final isNearLimit =
        spent >= budget.amount * (budget.warningThreshold ?? 0.8) &&
            !isOverBudget;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getBorderColor(isOverBudget, isNearLimit),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getPeriodColor(
                                  budget.period,
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _getPeriodText(budget.period),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _getPeriodColor(budget.period),
                                ),
                              ),
                            ),
                            if (budget.isRecurring) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.repeat,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Status Badge
                  if (isOverBudget || isNearLimit)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(isOverBudget, isNearLimit),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOverBudget ? Icons.error : Icons.warning,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOverBudget ? 'Exceeded' : 'Near Limit',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Actions Menu
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 12),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 12),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit' && onEdit != null) {
                        onEdit!();
                      } else if (value == 'delete' && onDelete != null) {
                        onDelete!();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Progress
              BudgetProgress(budget: budget),
              const SizedBox(height: 16),

              // Date Range
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_formatDate(budget.startDate)} - ${_formatDate(budget.endDate)}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              // Notes (if any)
              if (budget.notes != null && budget.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  budget.notes!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(bool isOverBudget, bool isNearLimit) {
    if (isOverBudget) return Colors.red;
    if (isNearLimit) return Colors.orange;
    return Colors.grey[300]!;
  }

  Color _getStatusColor(bool isOverBudget, bool isNearLimit) {
    if (isOverBudget) return Colors.red;
    if (isNearLimit) return Colors.orange;
    return Colors.green;
  }

  Color _getPeriodColor(BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.daily:
        return Colors.blue;
      case BudgetPeriod.weekly:
        return Colors.purple;
      case BudgetPeriod.monthly:
        return Colors.green;
      case BudgetPeriod.yearly:
        return Colors.orange;
      case BudgetPeriod.custom:
        return Colors.teal;
    }
  }

  String _getPeriodText(BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.daily:
        return 'Daily';
      case BudgetPeriod.weekly:
        return 'Weekly';
      case BudgetPeriod.monthly:
        return 'Monthly';
      case BudgetPeriod.yearly:
        return 'Yearly';
      case BudgetPeriod.custom:
        return 'Custom';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
