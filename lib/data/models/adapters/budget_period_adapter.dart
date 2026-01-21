import 'package:hive/hive.dart';

import '../budget_period.dart';

/// Hive Type Adapter for BudgetPeriod enum
///
/// This adapter tells Hive how to read and write BudgetPeriod enum values
/// to the local database.
///
/// Type ID: 1 (must be unique across all adapters in your app)
class BudgetPeriodAdapter extends TypeAdapter<BudgetPeriod> {
  @override
  final int typeId = 1;

  @override
  BudgetPeriod read(BinaryReader reader) {
    final index = reader.readByte();

    switch (index) {
      case 0:
        return BudgetPeriod.weekly;
      case 1:
        return BudgetPeriod.monthly;
      case 2:
        return BudgetPeriod.yearly;
      case 3:
        return BudgetPeriod.custom;
      default:
        return BudgetPeriod.monthly; // Default fallback
    }
  }

  @override
  void write(BinaryWriter writer, BudgetPeriod obj) {
    switch (obj) {
      case BudgetPeriod.weekly:
        writer.writeByte(0);
        break;
      case BudgetPeriod.monthly:
        writer.writeByte(1);
        break;
      case BudgetPeriod.yearly:
        writer.writeByte(2);
        break;
      case BudgetPeriod.custom:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
