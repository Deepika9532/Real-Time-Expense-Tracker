/// Enum representing different budget periods
///
/// This enum is used to define the time period for which a budget is set.
/// Each budget can have one of these periods.
enum BudgetPeriod {
  /// Budget that repeats every week
  weekly,

  /// Budget that repeats every month
  monthly,

  /// Budget that repeats every year
  yearly,

  /// Custom budget period defined by start and end dates
  custom,
}

/// Extension methods for BudgetPeriod
extension BudgetPeriodExtension on BudgetPeriod {
  /// Get a human-readable name for the period
  String get displayName {
    switch (this) {
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

  /// Get the period as a string for API/database
  String get value {
    switch (this) {
      case BudgetPeriod.weekly:
        return 'weekly';
      case BudgetPeriod.monthly:
        return 'monthly';
      case BudgetPeriod.yearly:
        return 'yearly';
      case BudgetPeriod.custom:
        return 'custom';
    }
  }

  /// Get duration in days (approximate for variable periods)
  int get daysCount {
    switch (this) {
      case BudgetPeriod.weekly:
        return 7;
      case BudgetPeriod.monthly:
        return 30;
      case BudgetPeriod.yearly:
        return 365;
      case BudgetPeriod.custom:
        return 0; // Calculated from start/end dates
    }
  }

  /// Parse from string value
  static BudgetPeriod fromString(String value) {
    switch (value.toLowerCase()) {
      case 'weekly':
        return BudgetPeriod.weekly;
      case 'monthly':
        return BudgetPeriod.monthly;
      case 'yearly':
        return BudgetPeriod.yearly;
      case 'custom':
        return BudgetPeriod.custom;
      default:
        return BudgetPeriod.monthly; // Default fallback
    }
  }
}
