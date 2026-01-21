import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/expense.dart';
import '../../providers/analytics_provider.dart';
import 'widgets/bar_chart_widget.dart';
import 'widgets/line_chart_widget.dart';
import 'widgets/pie_chart_widget.dart';
import 'widgets/spending_trend.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().loadAnalytics();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Expenses', icon: Icon(Icons.trending_down)),
            Tab(text: 'Income', icon: Icon(Icons.trending_up)),
          ],
        ),
        actions: [
          Consumer<AnalyticsProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<TimePeriod>(
                icon: const Icon(Icons.calendar_today),
                initialValue: provider.selectedPeriod,
                onSelected: (period) => provider.setTimePeriod(period),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: TimePeriod.daily,
                    child: Row(
                      children: [
                        Icon(Icons.today),
                        SizedBox(width: 12),
                        Text('Daily'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: TimePeriod.weekly,
                    child: Row(
                      children: [
                        Icon(Icons.view_week),
                        SizedBox(width: 12),
                        Text('Weekly'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: TimePeriod.monthly,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: 12),
                        Text('Monthly'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: TimePeriod.yearly,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_view_month),
                        SizedBox(width: 12),
                        Text('Yearly'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<AnalyticsProvider>(
        builder: (context, analyticsProvider, child) {
          if (analyticsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (analyticsProvider.hasError) {
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
                    analyticsProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => analyticsProvider.loadAnalytics(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildExpensesTab(analyticsProvider),
              _buildIncomeTab(analyticsProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpensesTab(AnalyticsProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadAnalytics(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Summary Cards
          _buildSummaryCards(provider),
          const SizedBox(height: 24),

          // Spending Trend
          const SpendingTrend(),
          const SizedBox(height: 24),

          // Category Distribution
          _buildChartCard(
            title: 'Spending by Category',
            subtitle: 'Distribution of expenses across categories',
            child: const SizedBox(height: 300, child: PieChartWidget()),
          ),
          const SizedBox(height: 24),

          // Top Categories
          _buildTopCategoriesCard(provider),
          const SizedBox(height: 24),

          // Time Comparison
          _buildChartCard(
            title: 'Time Comparison',
            subtitle: 'Compare spending over time',
            child: const SizedBox(height: 300, child: BarChartWidget()),
          ),
          const SizedBox(height: 24),

          // Trend Analysis
          _buildChartCard(
            title: 'Spending Trend',
            subtitle: 'Track your spending patterns',
            child: const SizedBox(height: 300, child: LineChartWidget()),
          ),
          const SizedBox(height: 24),

          // Statistics
          _buildStatisticsCard(provider),
        ],
      ),
    );
  }

  Widget _buildIncomeTab(AnalyticsProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadAnalytics(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Income Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Total Income',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    CurrencyFormatter.formatUSD(provider.totalIncome),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        'Average',
                        CurrencyFormatter.formatUSD(provider.averageIncome),
                        Icons.functions,
                      ),
                      _buildStatItem(
                        'Transactions',
                        provider.expenses
                            .where((e) => e.type == ExpenseType.income)
                            .length
                            .toString(),
                        Icons.receipt_long,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Income by Category
          _buildChartCard(
            title: 'Income by Category',
            subtitle: 'Distribution of income sources',
            child: const SizedBox(height: 300, child: PieChartWidget()),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(AnalyticsProvider provider) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Expenses',
            CurrencyFormatter.formatUSD(provider.totalExpenses),
            Icons.trending_down,
            Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Total Income',
            CurrencyFormatter.formatUSD(provider.totalIncome),
            Icons.trending_up,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTopCategoriesCard(AnalyticsProvider provider) {
    final topCategories = provider.topExpenseCategories;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Spending Categories',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...topCategories.map((item) {
              final category = item['category'];
              final amount = item['amount'] as double;
              final percentage = item['percentage'] as double;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(category.color).withOpacity(0.2),
                      child: Icon(
                        Icons.category,
                        color: Color(category.color),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation(
                              Color(category.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.formatUSD(amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(AnalyticsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Avg. Expense',
                    CurrencyFormatter.formatUSD(provider.averageExpense),
                    Icons.functions,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Transactions',
                    provider.transactionCount.toString(),
                    Icons.receipt_long,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Balance',
                    CurrencyFormatter.formatUSD(provider.balance),
                    Icons.account_balance_wallet,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Avg. Income',
                    CurrencyFormatter.formatUSD(provider.averageIncome),
                    Icons.attach_money,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
