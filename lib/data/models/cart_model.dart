import 'package:hive/hive.dart';

import 'product_model.dart';

part 'adapters/cart_model_adapter.dart';

/// Cart item model representing a product in the shopping cart
@HiveType(typeId: 3)
class CartItemModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final String productName;

  @HiveField(3)
  final double productPrice;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final String? imageUrl;

  @HiveField(6)
  final String? categoryId;

  @HiveField(7)
  final double? discount;

  @HiveField(8)
  final String? unit;

  @HiveField(9)
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    this.imageUrl,
    this.categoryId,
    this.discount,
    this.unit,
    required this.addedAt,
  });

  /// Calculate subtotal for this item
  double get subtotal => productPrice * quantity;

  /// Calculate final price after discount
  double get finalPrice {
    if (discount != null && discount! > 0) {
      return productPrice * (1 - (discount! / 100));
    }
    return productPrice;
  }

  /// Calculate total for this item including discount
  double get total => finalPrice * quantity;

  /// Calculate discount amount for this item
  double get discountAmount {
    if (discount != null && discount! > 0) {
      return (productPrice - finalPrice) * quantity;
    }
    return 0.0;
  }

  /// Create from product
  factory CartItemModel.fromProduct(ProductModel product, {int quantity = 1}) {
    return CartItemModel(
      id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      productName: product.name,
      productPrice: product.price,
      quantity: quantity,
      imageUrl: product.imageUrl,
      categoryId: product.categoryId,
      discount: product.discount,
      unit: product.unit,
      addedAt: DateTime.now(),
    );
  }

  /// From JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productPrice: (json['product_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['image_url'] as String?,
      categoryId: json['category_id'] as String?,
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      unit: json['unit'] as String?,
      addedAt: json['added_at'] != null
          ? DateTime.parse(json['added_at'] as String)
          : DateTime.now(),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'quantity': quantity,
      'image_url': imageUrl,
      'category_id': categoryId,
      'discount': discount,
      'unit': unit,
      'added_at': addedAt.toIso8601String(),
    };
  }

  /// Copy with
  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    double? productPrice,
    int? quantity,
    String? imageUrl,
    String? categoryId,
    double? discount,
    String? unit,
    DateTime? addedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      discount: discount ?? this.discount,
      unit: unit ?? this.unit,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel &&
        other.id == id &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CartItemModel(id: $id, product: $productName, quantity: $quantity, total: $total)';
  }
}

/// Shopping cart model
@HiveType(typeId: 4)
class CartModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final List<CartItemModel> items;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  @HiveField(5)
  final String? couponCode;

  @HiveField(6)
  final double? couponDiscount; // Percentage or flat amount

  @HiveField(7)
  final bool isCouponPercentage;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    this.couponCode,
    this.couponDiscount,
    this.isCouponPercentage = true,
  });

  /// Total number of items in cart
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Total number of unique products
  int get productCount => items.length;

  /// Subtotal before discounts
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Total item discounts
  double get itemDiscounts =>
      items.fold(0.0, (sum, item) => sum + item.discountAmount);

  /// Coupon discount amount
  double get couponDiscountAmount {
    if (couponDiscount == null || couponDiscount! <= 0) return 0.0;

    if (isCouponPercentage) {
      final afterItemDiscounts = subtotal - itemDiscounts;
      return afterItemDiscounts * (couponDiscount! / 100);
    } else {
      return couponDiscount!;
    }
  }

  /// Total discounts (items + coupon)
  double get totalDiscounts => itemDiscounts + couponDiscountAmount;

  /// Grand total after all discounts
  double get total {
    final afterItemDiscounts = subtotal - itemDiscounts;
    final afterCoupon = afterItemDiscounts - couponDiscountAmount;
    return afterCoupon.clamp(0.0, double.infinity);
  }

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Check if cart is not empty
  bool get isNotEmpty => items.isNotEmpty;

  /// Get item by product ID
  CartItemModel? getItem(String productId) {
    try {
      return items.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }

  /// Check if product is in cart
  bool hasProduct(String productId) {
    return items.any((item) => item.productId == productId);
  }

  /// Get quantity of a product
  int getProductQuantity(String productId) {
    final item = getItem(productId);
    return item?.quantity ?? 0;
  }

  /// From JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      couponCode: json['coupon_code'] as String?,
      couponDiscount: json['coupon_discount'] != null
          ? (json['coupon_discount'] as num).toDouble()
          : null,
      isCouponPercentage: json['is_coupon_percentage'] as bool? ?? true,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'is_coupon_percentage': isCouponPercentage,
    };
  }

  /// Copy with
  CartModel copyWith({
    String? id,
    String? userId,
    List<CartItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? couponCode,
    double? couponDiscount,
    bool? isCouponPercentage,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      couponCode: couponCode ?? this.couponCode,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      isCouponPercentage: isCouponPercentage ?? this.isCouponPercentage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel && other.id == id && other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CartModel(id: $id, items: ${items.length}, total: $total)';
  }
}
