
// lib/models/service_model.dart
class ServiceModel {
  final String id;
  final String name;
  final String description;
  final int days; // Duration in days
  final double price;
  final List<String> features;
  final List<String> specifications;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.days,
    required this.price,
    required this.features,
    required this.specifications,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'days': days,
      'price': price,
      'features': features,
      'specifications': specifications,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      days: map['days'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      features: List<String>.from(map['features'] ?? []),
      specifications: List<String>.from(map['specifications'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    int? days,
    double? price,
    List<String>? features,
    List<String>? specifications,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      days: days ?? this.days,
      price: price ?? this.price,
      features: features ?? this.features,
      specifications: specifications ?? this.specifications,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}