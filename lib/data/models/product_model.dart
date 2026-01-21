import 'package:hive/hive.dart';

part 'adapters/product_model_adapter.dart';

/// Product model for e-commerce/shopping features
///
/// This model can be used for:
/// - Shopping list items
/// - Expense categories with product suggestions
/// - Receipt scanning product recognition
@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String? categoryId;

  @HiveField(5)
  final String? categoryName;

  @HiveField(6)
  final String? imageUrl;

  @HiveField(7)
  final String? barcode;

  @HiveField(8)
  final String? brand;

  @HiveField(9)
  final String? unit; // e.g., "kg", "lbs", "pcs"

  @HiveField(10)
  final double? weight;

  @HiveField(11)
  final bool isAvailable;

  @HiveField(12)
  final int? stockQuantity;

  @HiveField(13)
  final double? discount; // Percentage (0-100)

  @HiveField(14)
  final String? store;

  @HiveField(15)
  final DateTime? lastPurchased;

  @HiveField(16)
  final int? purchaseCount;

  @HiveField(17)
  final bool isFavorite;

  @HiveField(18)
  final List<String>? tags;

  @HiveField(19)
  final DateTime createdAt;

  @HiveField(20)
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.barcode,
    this.brand,
    this.unit,
    this.weight,
    this.isAvailable = true,
    this.stockQuantity,
    this.discount,
    this.store,
    this.lastPurchased,
    this.purchaseCount,
    this.isFavorite = false,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Calculate final price after discount
  double get finalPrice {
    if (discount != null && discount! > 0) {
      return price * (1 - (discount! / 100));
    }
    return price;
  }

  /// Calculate discount amount
  double get discountAmount {
    if (discount != null && discount! > 0) {
      return price * (discount! / 100);
    }
    return 0.0;
  }

  /// Check if product is on sale
  bool get isOnSale => discount != null && discount! > 0;

  /// From JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      imageUrl: json['image_url'] as String?,
      barcode: json['barcode'] as String?,
      brand: json['brand'] as String?,
      unit: json['unit'] as String?,
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      isAvailable: json['is_available'] as bool? ?? true,
      stockQuantity: json['stock_quantity'] as int?,
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      store: json['store'] as String?,
      lastPurchased: json['last_purchased'] != null
          ? DateTime.parse(json['last_purchased'] as String)
          : null,
      purchaseCount: json['purchase_count'] as int?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'category_name': categoryName,
      'image_url': imageUrl,
      'barcode': barcode,
      'brand': brand,
      'unit': unit,
      'weight': weight,
      'is_available': isAvailable,
      'stock_quantity': stockQuantity,
      'discount': discount,
      'store': store,
      'last_purchased': lastPurchased?.toIso8601String(),
      'purchase_count': purchaseCount,
      'is_favorite': isFavorite,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Copy with
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? categoryId,
    String? categoryName,
    String? imageUrl,
    String? barcode,
    String? brand,
    String? unit,
    double? weight,
    bool? isAvailable,
    int? stockQuantity,
    double? discount,
    String? store,
    DateTime? lastPurchased,
    int? purchaseCount,
    bool? isFavorite,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      barcode: barcode ?? this.barcode,
      brand: brand ?? this.brand,
      unit: unit ?? this.unit,
      weight: weight ?? this.weight,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      discount: discount ?? this.discount,
      store: store ?? this.store,
      lastPurchased: lastPurchased ?? this.lastPurchased,
      purchaseCount: purchaseCount ?? this.purchaseCount,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.imageUrl == imageUrl &&
        other.barcode == barcode &&
        other.brand == brand &&
        other.unit == unit &&
        other.weight == weight &&
        other.isAvailable == isAvailable &&
        other.stockQuantity == stockQuantity &&
        other.discount == discount &&
        other.store == store &&
        other.lastPurchased == lastPurchased &&
        other.purchaseCount == purchaseCount &&
        other.isFavorite == isFavorite &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, finalPrice: $finalPrice)';
  }
}
