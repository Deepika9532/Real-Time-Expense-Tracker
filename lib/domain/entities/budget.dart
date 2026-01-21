import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String id;
  final String name;
  final String categoryId;
  final double amount;
  final BudgetPeriod period;
  final DateTime startDate;
  final DateTime endDate;
  final double spent;
  final bool isActive;
  final bool notifyOnExceed;
  final double? warningThreshold;
  final String? userId;
  final String? description;
  final bool isRecurring;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? notes;

  const Budget({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.amount,
    required this.period,
    required this.startDate,
    required this.endDate,
    this.spent = 0.0,
    this.isActive = true,
    this.notifyOnExceed = false,
    this.warningThreshold,
    this.userId,
    this.description,
    this.isRecurring = false,
    this.createdAt,
    this.updatedAt,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        amount,
        period,
        startDate,
        endDate,
        spent,
        isActive,
        notifyOnExceed,
        warningThreshold,
        userId,
        description,
        isRecurring,
        createdAt,
        updatedAt,
        notes,
      ];

  // ========== CALCULATED PROPERTIES ==========

  /// Remaining budget amount
  double get remaining => (amount - spent).clamp(0, double.infinity);

  /// Percentage of budget spent (0-100)
  double get progressPercentage {
    if (amount == 0) return 0;
    return (spent / amount * 100).clamp(0, 100);
  }

  /// Percentage as decimal (0-1)
  double get progressDecimal => progressPercentage / 100;

  /// Daily spending allowance based on remaining days
  double get dailyAllowance {
    final daysRemaining = this.daysRemaining;
    if (daysRemaining <= 0) return 0;
    return remaining / daysRemaining;
  }

  /// Days remaining until budget end date
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  /// Budget period name (e.g., "Monthly", "Weekly")
  String get periodName {
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

  /// Budget status based on spending progress
  BudgetStatus get status {
    if (isExpired) return BudgetStatus.expired;
    if (isExceeded) return BudgetStatus.exceeded;
    if (isWarningReached) return BudgetStatus.warning;
    return BudgetStatus.onTrack;
  }

  /// Check if budget is exceeded
  bool get isExceeded => spent > amount;

  /// Check if budget is expired
  bool get isExpired => DateTime.now().isAfter(endDate);

  /// Check if warning threshold is reached
  bool get isWarningReached {
    if (warningThreshold == null) return false;
    return progressPercentage >= warningThreshold!;
  }

  /// Check if notifications should be sent
  bool get shouldNotify => notifyOnExceed && (isExceeded || isWarningReached);

  // ========== HELPER METHODS ==========

  /// Add expense to this budget
  Budget addExpense(double expenseAmount) {
    return copyWith(spent: spent + expenseAmount);
  }

  /// Remove expense from this budget
  Budget removeExpense(double expenseAmount) {
    return copyWith(spent: (spent - expenseAmount).clamp(0, double.infinity));
  }

  /// Reset spent amount to zero
  Budget reset() {
    return copyWith(spent: 0.0);
  }

  /// Create a recurring budget for the next period
  Budget createNextPeriodBudget() {
    if (!isRecurring) return this;

    DateTime newStartDate;
    DateTime newEndDate;

    switch (period) {
      case BudgetPeriod.daily:
        newStartDate = startDate.add(const Duration(days: 1));
        newEndDate = endDate.add(const Duration(days: 1));
        break;
      case BudgetPeriod.weekly:
        newStartDate = startDate.add(const Duration(days: 7));
        newEndDate = endDate.add(const Duration(days: 7));
        break;
      case BudgetPeriod.monthly:
        newStartDate =
            DateTime(startDate.year, startDate.month + 1, startDate.day);
        newEndDate = DateTime(endDate.year, endDate.month + 1, endDate.day);
        break;
      case BudgetPeriod.yearly:
        newStartDate =
            DateTime(startDate.year + 1, startDate.month, startDate.day);
        newEndDate = DateTime(endDate.year + 1, endDate.month, endDate.day);
        break;
      case BudgetPeriod.custom:
        final duration = endDate.difference(startDate);
        newStartDate = startDate.add(duration);
        newEndDate = endDate.add(duration);
        break;
    }

    return copyWith(
      id: '${id}_${newStartDate.millisecondsSinceEpoch}',
      startDate: newStartDate,
      endDate: newEndDate,
      spent: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // ========== VALIDATION METHODS ==========

  /// Validate budget data
  List<String> validate() {
    final errors = <String>[];

    if (name.isEmpty) {
      errors.add('Budget name is required');
    }

    if (amount <= 0) {
      errors.add('Budget amount must be greater than 0');
    }

    if (categoryId.isEmpty) {
      errors.add('Category is required');
    }

    if (endDate.isBefore(startDate)) {
      errors.add('End date must be after start date');
    }

    if (warningThreshold != null &&
        (warningThreshold! <= 0 || warningThreshold! > 100)) {
      errors.add('Warning threshold must be between 1 and 100');
    }

    return errors;
  }

  /// Check if budget is valid
  bool get isValid => validate().isEmpty;

  /// Check if budget is active and not expired
  bool get isCurrent {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }

  // ========== COPY WITH METHOD ==========

  Budget copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? amount,
    BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    double? spent,
    bool? isActive,
    bool? notifyOnExceed,
    double? warningThreshold,
    String? userId,
    String? description,
    bool? isRecurring,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      spent: spent ?? this.spent,
      isActive: isActive ?? this.isActive,
      notifyOnExceed: notifyOnExceed ?? this.notifyOnExceed,
      warningThreshold: warningThreshold ?? this.warningThreshold,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      isRecurring: isRecurring ?? this.isRecurring,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  // ========== FACTORY METHODS ==========

  /// Create a monthly budget for the current month
  factory Budget.monthly({
    required String id,
    required String name,
    required String categoryId,
    required double amount,
    String? userId,
    String? description,
    bool notifyOnExceed = false,
    double? warningThreshold,
    bool isRecurring = false,
    String? notes,
  }) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return Budget(
      id: id,
      name: name,
      categoryId: categoryId,
      amount: amount,
      period: BudgetPeriod.monthly,
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      description: description,
      notifyOnExceed: notifyOnExceed,
      warningThreshold: warningThreshold,
      isRecurring: isRecurring,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Create a weekly budget for the current week
  factory Budget.weekly({
    required String id,
    required String name,
    required String categoryId,
    required double amount,
    String? userId,
    String? description,
    bool notifyOnExceed = false,
    double? warningThreshold,
    bool isRecurring = false,
    String? notes,
  }) {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: now.weekday - 1));
    final endDate = startDate
        .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    return Budget(
      id: id,
      name: name,
      categoryId: categoryId,
      amount: amount,
      period: BudgetPeriod.weekly,
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      description: description,
      notifyOnExceed: notifyOnExceed,
      warningThreshold: warningThreshold,
      isRecurring: isRecurring,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Create a yearly budget for the current year
  factory Budget.yearly({
    required String id,
    required String name,
    required String categoryId,
    required double amount,
    String? userId,
    String? description,
    bool notifyOnExceed = false,
    double? warningThreshold,
    bool isRecurring = false,
    String? notes,
  }) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, 1, 1);
    final endDate = DateTime(now.year, 12, 31, 23, 59, 59);

    return Budget(
      id: id,
      name: name,
      categoryId: categoryId,
      amount: amount,
      period: BudgetPeriod.yearly,
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      description: description,
      notifyOnExceed: notifyOnExceed,
      warningThreshold: warningThreshold,
      isRecurring: isRecurring,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  // ========== JSON SERIALIZATION ==========

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'amount': amount,
      'period': period.index,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'spent': spent,
      'isActive': isActive,
      'notifyOnExceed': notifyOnExceed,
      'warningThreshold': warningThreshold,
      'userId': userId,
      'description': description,
      'isRecurring': isRecurring,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  /// Create from JSON map
  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      amount: (json['amount'] as num).toDouble(),
      period: BudgetPeriod.values[json['period'] as int],
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? true,
      notifyOnExceed: json['notifyOnExceed'] as bool? ?? false,
      warningThreshold: (json['warningThreshold'] as num?)?.toDouble(),
      userId: json['userId'] as String?,
      description: json['description'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      notes: json['notes'] as String?,
    );
  }
}

enum BudgetPeriod { daily, weekly, monthly, yearly, custom }

enum BudgetStatus { onTrack, warning, exceeded, expired }
