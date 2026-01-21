import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/currency_formatter.dart';
import '../../../providers/analytics_provider.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<int> showingTooltipOnSpots = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalyticsProvider>(
      builder: (context, provider, child) {
        final timeSeriesData = provider.getTimeSeriesChartData();

        if (timeSeriesData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No data available',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        final maxY = timeSeriesData
            .map((e) => e['amount'] as double)
            .reduce((a, b) => a > b ? a : b);
        final minY = timeSeriesData
            .map((e) => e['amount'] as double)
            .reduce((a, b) => a < b ? a : b);

        return Padding(
          padding: const EdgeInsets.only(right: 16, top: 16),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: (timeSeriesData.length - 1).toDouble(),
              minY: minY * 0.9,
              maxY: maxY * 1.1,
              lineTouchData: LineTouchData(
                enabled: true,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.lineBarSpots == null) {
                    setState(() {
                      showingTooltipOnSpots.clear();
                    });
                    return;
                  }
                  setState(() {
                    showingTooltipOnSpots =
                        response.lineBarSpots!.map((e) => e.spotIndex).toList();
                  });
                },
                touchTooltipData: LineTouchTooltipData(
                  // FIXED: Changed from tooltipBgColor to getTooltipColor
                  getTooltipColor: (touchedSpot) => Colors.black87,
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final data = timeSeriesData[barSpot.spotIndex];
                      final date = data['date'] as DateTime;
                      return LineTooltipItem(
                        '${_getDateLabel(date)}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: CurrencyFormatter.formatUSD(barSpot.y),
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
                getTouchedSpotIndicator: (barData, spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: Theme.of(context).colorScheme.primary,
                        strokeWidth: 2,
                        dashArray: [5, 5],
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Theme.of(context).colorScheme.primary,
                          );
                        },
                      ),
                    );
                  }).toList();
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    interval: (maxY - minY) / 5,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        CurrencyFormatter.formatCompact(value),
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= timeSeriesData.length ||
                          value.toInt() < 0) {
                        return const SizedBox();
                      }
                      final data = timeSeriesData[value.toInt()];
                      final date = data['date'] as DateTime;

                      // Show every nth label based on data size
                      final showEvery = (timeSeriesData.length / 6).ceil();
                      if (value.toInt() % showEvery != 0 &&
                          value.toInt() != timeSeriesData.length - 1) {
                        return const SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _getShortDateLabel(date),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                  left: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: (maxY - minY) / 5,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey[300]!,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: timeSeriesData.asMap().entries.map((entry) {
                    return FlSpot(
                      entry.key.toDouble(),
                      entry.value['amount'] as double,
                    );
                  }).toList(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: Theme.of(context).colorScheme.primary,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        Theme.of(context).colorScheme.primary.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDateLabel(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getShortDateLabel(DateTime date) {
    final context = this.context.read<AnalyticsProvider>();
    switch (context.selectedPeriod) {
      case TimePeriod.daily:
        return '${date.day}/${date.month}';
      case TimePeriod.weekly:
        return 'W${((date.day - 1) / 7).floor() + 1}';
      case TimePeriod.monthly:
        return _getMonthName(date.month);
      case TimePeriod.yearly:
        return date.year.toString();
      default:
        return '${date.day}/${date.month}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
