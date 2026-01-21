import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/analytics_provider.dart';
import '../../../../../core/utils/currency_formatter.dart';

class SpendingTrend extends StatelessWidget {
  const SpendingTrend({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalyticsProvider>(
      builder: (context, provider, child) {
        final trend = provider.expenseTrend;
        final trendType = trend['trend'] as String;
        final percentage = trend['percentage'] as double;
        final comparison = provider.getComparisonData();

        return Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getTrendColor(trendType).withOpacity(0.1),
                  _getTrendColor(trendType).withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spending Trend',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getTrendColor(trendType).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getTrendIcon(trendType),
                            size: 16,
                            color: _getTrendColor(trendType),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getTrendText(trendType),
                            style: TextStyle(
                              color: _getTrendColor(trendType),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Trend Visualization
                Row(
                  children: [
                    Expanded(
                      child: _buildTrendIndicator(
                        context,
                        trendType,
                        percentage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Comparison Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildComparisonItem(
                            context,
                            'Current Period',
                            comparison['current'] as double,
                            Icons.calendar_today,
                            Theme.of(context).colorScheme.primary,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildComparisonItem(
                            context,
                            'Previous Period',
                            comparison['previous'] as double,
                            Icons.history,
                            Colors.grey[600]!,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            comparison['isIncreased'] as bool
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 20,
                            color: comparison['isIncreased'] as bool
                                ? Colors.red
                                : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${CurrencyFormatter.formatUSD((comparison['difference'] as double).abs())} ',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: comparison['isIncreased'] as bool
                                      ? Colors.red
                                      : Colors.green,
                                ),
                          ),
                          Text(
                            '(${(comparison['percentageChange'] as double).abs().toStringAsFixed(1)}%)',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrendIndicator(
    BuildContext context,
    String trendType,
    double percentage,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getTrendColor(trendType).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getTrendIcon(trendType),
                size: 48,
                color: _getTrendColor(trendType),
              ),
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: _getTrendColor(trendType),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getTrendDescription(trendType),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComparisonItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyFormatter.formatUSD(amount),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trendType) {
    switch (trendType) {
      case 'increasing':
        return Colors.red;
      case 'decreasing':
        return Colors.green;
      case 'stable':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrendIcon(String trendType) {
    switch (trendType) {
      case 'increasing':
        return Icons.trending_up;
      case 'decreasing':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  String _getTrendText(String trendType) {
    switch (trendType) {
      case 'increasing':
        return 'Increasing';
      case 'decreasing':
        return 'Decreasing';
      case 'stable':
        return 'Stable';
      default:
        return 'Unknown';
    }
  }

  String _getTrendDescription(String trendType) {
    switch (trendType) {
      case 'increasing':
        return 'vs previous period';
      case 'decreasing':
        return 'vs previous period';
      case 'stable':
        return 'No significant change';
      default:
        return '';
    }
  }
}
