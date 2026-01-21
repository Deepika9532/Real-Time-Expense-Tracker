import 'package:hive/hive.dart';

import '../budget_model.dart';

/// Hive Type Adapter for BudgetModel
///
/// This adapter tells Hive how to read and write BudgetModel objects
/// to the local database.
///
/// Type ID: 0 (must be unique across all adapters in your app)
class BudgetModelAdapter extends TypeAdapter<BudgetModel> {
  @override
  final int typeId = 0;

  @override
  BudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return BudgetModel(
      id: fields[0] as String,
      name: fields[1] as String,
      categoryId: fields[2] as String,
      amount: fields[3] as double,
      period: fields[4] as int,
      startDate: fields[5] as String,
      endDate: fields[6] as String,
      spent: fields[7] as double? ?? 0.0,
      isActive: fields[8] as bool? ?? true,
      notifyOnExceed: fields[9] as bool? ?? false,
      warningThreshold: fields[10] as double?,
      userId: fields[11] as String?,
      description: fields[12] as String?,
      isRecurring: fields[13] as bool? ?? false,
      createdAt: fields[14] as String?,
      updatedAt: fields[15] as String?,
      notes: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetModel obj) {
    writer
      ..writeByte(17) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.period)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.spent)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.notifyOnExceed)
      ..writeByte(10)
      ..write(obj.warningThreshold)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.isRecurring)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
