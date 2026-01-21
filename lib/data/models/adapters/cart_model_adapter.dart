part of '../cart_model.dart';

/// Hive Type Adapter for CartItemModel
///
/// Type ID: 3 (must be unique across all adapters in your app)
class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 3;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return CartItemModel(
      id: fields[0] as String,
      productId: fields[1] as String,
      productName: fields[2] as String,
      productPrice: fields[3] as double,
      quantity: fields[4] as int,
      imageUrl: fields[5] as String?,
      categoryId: fields[6] as String?,
      discount: fields[7] as double?,
      unit: fields[8] as String?,
      addedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(10) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.productPrice)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.unit)
      ..writeByte(9)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

/// Hive Type Adapter for CartModel
///
/// Type ID: 4 (must be unique across all adapters in your app)
class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 4;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return CartModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      items: (fields[2] as List).cast<CartItemModel>(),
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
      couponCode: fields[5] as String?,
      couponDiscount: fields[6] as double?,
      isCouponPercentage: fields[7] as bool? ?? true,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(8) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.couponCode)
      ..writeByte(6)
      ..write(obj.couponDiscount)
      ..writeByte(7)
      ..write(obj.isCouponPercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
