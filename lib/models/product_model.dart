
class ProductModel {
  final String id;
  final String name;
  final String sku;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final bool isInStock;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.isInStock,
    required this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'isInStock': isInStock,
      'createdAt': createdAt.toIso8601String(),
    };
  }


  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      sku: map['sku'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      isInStock: map['isInStock'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}