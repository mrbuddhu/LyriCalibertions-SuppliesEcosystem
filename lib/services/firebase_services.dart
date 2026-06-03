// lib/services/firebase_services.dart - COMPLETE FILE
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../helpers/databse_constants.dart';
import '../models/cate_model.dart';
import '../models/product_model.dart';
import '../models/service_model.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ========== IMAGE UPLOAD FOR WEB ==========

  Future<String> uploadProductImageWeb(
      Uint8List imageBytes,
      String fileName,
      String productId,
      ) async {
    try {
      String extension = fileName.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(extension)) {
        extension = 'jpg';
      }

      final storageRef = _storage.ref().child('product_images/$productId.$extension');

      final metadata = SettableMetadata(
        contentType: 'image/$extension',
        customMetadata: {
          'uploaded': DateTime.now().toIso8601String(),
        },
      );

      final uploadTask = await storageRef.putData(imageBytes, metadata);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      print('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<String> uploadServiceImageWeb(
      Uint8List imageBytes,
      String fileName,
      String serviceId,
      ) async {
    try {
      String extension = fileName.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(extension)) {
        extension = 'jpg';
      }

      final storageRef = _storage.ref().child('service_images/$serviceId.$extension');

      final metadata = SettableMetadata(
        contentType: 'image/$extension',
        customMetadata: {
          'uploaded': DateTime.now().toIso8601String(),
        },
      );

      final uploadTask = await storageRef.putData(imageBytes, metadata);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      print('Service image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading service image: $e');
      rethrow;
    }
  }

  // ========== CATEGORY OPERATIONS ==========

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _database.child(DbTables.categories).child(category.id).set(category.toMap());
    } catch (e) {
      print('Error adding category: $e');
      rethrow;
    }
  }

  Stream<List<CategoryModel>> getCategories() {
    return _database.child(DbTables.categories).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final Map<dynamic, dynamic> categoriesMap = data as Map<dynamic, dynamic>;
      return categoriesMap.entries.map((entry) {
        final categoryData = Map<String, dynamic>.from(entry.value as Map);
        return CategoryModel.fromMap(categoryData);
      }).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _database.child(DbTables.categories).child(categoryId).remove();
    } catch (e) {
      print('Error deleting category: $e');
      rethrow;
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _database
        .child(DbTables.categories)
        .child(category.id)
        .update(category.toMap());
  }

  // ========== PRODUCT OPERATIONS ==========

  Future<void> addProduct(ProductModel product) async {
    try {
      await _database.child(DbTables.products).child(product.id).set(product.toMap());
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    await _database
        .child(DbTables.products)
        .child(product.id)
        .update(product.toMap());
  }

  Stream<List<ProductModel>> getProducts() {
    return _database.child(DbTables.products).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final Map<dynamic, dynamic> productsMap = data as Map<dynamic, dynamic>;
      return productsMap.entries.map((entry) {
        final productData = Map<String, dynamic>.from(entry.value as Map);
        return ProductModel.fromMap(productData);
      }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _database.child(DbTables.products).child(productId).remove();
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  Stream<List<ProductModel>> getProductsByCategory(String category) {
    return _database.child(DbTables.products).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final Map<dynamic, dynamic> productsMap = data as Map<dynamic, dynamic>;
      return productsMap.entries
          .map((entry) {
        final productData = Map<String, dynamic>.from(entry.value as Map);
        return ProductModel.fromMap(productData);
      })
          .where((product) => product.category == category)
          .toList();
    });
  }

  Future<void> updateProductStock(String productId, bool isInStock) async {
    try {
      await _database.child(DbTables.products).child(productId).update({
        'isInStock': isInStock,
      });
    } catch (e) {
      print('Error updating stock: $e');
      rethrow;
    }
  }

  // ========== SERVICE OPERATIONS ==========

  Future<void> addService(ServiceModel service) async {
    try {
      await _database.child(DbTables.services).child(service.id).set(service.toMap());
    } catch (e) {
      print('Error adding service: $e');
      rethrow;
    }
  }

  Future<void> updateService(ServiceModel service) async {
    try {
      await _database
          .child(DbTables.services)
          .child(service.id)
          .update(service.toMap());
    } catch (e) {
      print('Error updating service: $e');
      rethrow;
    }
  }

  Stream<List<ServiceModel>> getServices() {
    return _database.child(DbTables.services).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final Map<dynamic, dynamic> servicesMap = data as Map<dynamic, dynamic>;
      return servicesMap.entries.map((entry) {
        final serviceData = Map<String, dynamic>.from(entry.value as Map);
        return ServiceModel.fromMap(serviceData);
      }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _database.child(DbTables.services).child(serviceId).remove();
    } catch (e) {
      print('Error deleting service: $e');
      rethrow;
    }
  }

  Future<void> updateServiceStatus(String serviceId, bool isActive) async {
    try {
      await _database.child(DbTables.services).child(serviceId).update({
        'isActive': isActive,
      });
    } catch (e) {
      print('Error updating service status: $e');
      rethrow;
    }
  }
}