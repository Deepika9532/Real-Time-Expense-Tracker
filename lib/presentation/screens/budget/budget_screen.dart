import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/budget.dart';
import '../../providers/budget_provider.dart';
import 'widgets/budget_card.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetProvider>().loadBudgets(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        actions: [
          Consumer<BudgetProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                onSelected: (value) {
                  if (value == 'all') {
                    provider.clearFilters();
                  } else if (value == 'active') {
                    provider.toggleShowInactiveBudgets();
                  } else {
                    final period = BudgetPeriod.values.firstWhere(
                      (p) => p.toString().split('.').last == value,
                    );
                    provider.setPeriodFilter(period);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'all', child: Text('All Budgets')),
                  const PopupMenuItem(
                    value: 'active',
                    child: Text('Active Only'),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'daily', child: Text('Daily')),
                  const PopupMenuItem(value: 'weekly', child: Text('Weekly')),
                  const PopupMenuItem(value: 'monthly', child: Text('Monthly')),
                  const PopupMenuItem(value: 'yearly', child: Text('Yearly')),
                  const PopupMenuItem(value: 'custom', child: Text('Custom')),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          if (budgetProvider.isLoading && budgetProvider.budgets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (budgetProvider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    budgetProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => budgetProvider.loadBudgets(refresh: true),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (budgetProvider.filteredBudgets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No budgets yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your first budget to track spending',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to add budget screen
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Budget'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => budgetProvider.loadBudgets(refresh: true),
            child: CustomScrollView(
              slivers: [
                // Overall Summary
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildOverallSummary(budgetProvider),
                  ),
                ),

                // Alert Section (if any budgets are exceeded or near limit)
                if (budgetProvider.overdraftBudgets.isNotEmpty ||
                    budgetProvider.nearLimitBudgets.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildAlertSection(budgetProvider),
                    ),
                  ),

                // Budget List
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final budget = budgetProvider.filteredBudgets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BudgetCard(
                          budget: budget,
                          onTap: () {
                            // Navigate to budget details
                          },
                          onEdit: () {
                            // Navigate to edit budget
                          },
                          onDelete: () async {
                            final confirmed = await _showDeleteConfirmation(
                              context,
                              budget.name,
                            );
                            if (confirmed == true) {
                              await budgetProvider.deleteBudget(budget.id);
                            }
                          },
                        ),
                      );
                    }, childCount: budgetProvider.filteredBudgets.length),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to add budget screen
        },
        icon: const Icon(Icons.add),
        label: const Text('New Budget'),
      ),
    );
  }

  Widget _buildOverallSummary(BudgetProvider provider) {
    final summary = provider.getBudgetSummary();

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Budget',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${summary['activeBudgets']} Active',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Total Budget',
                    CurrencyFormatter.formatUSD(
                      summary['totalAmount'] as double,
                    ),
                    Icons.account_balance_wallet,
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    'Total Spent',
                    CurrencyFormatter.formatUSD(
                      summary['totalSpent'] as double,
                    ),
                    Icons.payments,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Remaining',
                    CurrencyFormatter.formatUSD(
                      summary['totalRemaining'] as double,
                    ),
                    Icons.savings,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    'Progress',
                    '${((summary['overallProgress'] as double) * 100).toStringAsFixed(0)}%',
                    Icons.trending_up,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSection(BudgetProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (provider.overdraftBudgets.isNotEmpty) ...[
          _buildAlertCard(
            'Budget Exceeded',
            '${provider.overdraftBudgets.length} budget(s) have exceeded their limit',
            Icons.error,
            Colors.red,
          ),
          const SizedBox(height: 12),
        ],
        if (provider.nearLimitBudgets.isNotEmpty) ...[
          _buildAlertCard(
            'Near Limit',
            '${provider.nearLimitBudgets.length} budget(s) are approaching their limit',
            Icons.warning,
            Colors.orange,
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildAlertCard(
    String title,
    String message,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    String budgetName,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Budget'),
        content: Text('Are you sure you want to delete "$budgetName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
