part of '../product_model.dart';

/// Hive Type Adapter for ProductModel
///
/// This adapter tells Hive how to read and write ProductModel objects
/// to the local database.
///
/// Type ID: 2 (must be unique across all adapters in your app)
class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ProductModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String?,
      price: fields[3] as double,
      categoryId: fields[4] as String?,
      categoryName: fields[5] as String?,
      imageUrl: fields[6] as String?,
      barcode: fields[7] as String?,
      brand: fields[8] as String?,
      unit: fields[9] as String?,
      weight: fields[10] as double?,
      isAvailable: fields[11] as bool? ?? true,
      stockQuantity: fields[12] as int?,
      discount: fields[13] as double?,
      store: fields[14] as String?,
      lastPurchased: fields[15] as DateTime?,
      purchaseCount: fields[16] as int?,
      isFavorite: fields[17] as bool? ?? false,
      tags: fields[18] != null ? (fields[18] as List).cast<String>() : null,
      createdAt: fields[19] as DateTime,
      updatedAt: fields[20] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(21) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.categoryName)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.barcode)
      ..writeByte(8)
      ..write(obj.brand)
      ..writeByte(9)
      ..write(obj.unit)
      ..writeByte(10)
      ..write(obj.weight)
      ..writeByte(11)
      ..write(obj.isAvailable)
      ..writeByte(12)
      ..write(obj.stockQuantity)
      ..writeByte(13)
      ..write(obj.discount)
      ..writeByte(14)
      ..write(obj.store)
      ..writeByte(15)
      ..write(obj.lastPurchased)
      ..writeByte(16)
      ..write(obj.purchaseCount)
      ..writeByte(17)
      ..write(obj.isFavorite)
      ..writeByte(18)
      ..write(obj.tags)
      ..writeByte(19)
      ..write(obj.createdAt)
      ..writeByte(20)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
