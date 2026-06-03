
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/views/screens/product_Detail_screen.dart';

import '../../models/cate_model.dart';
import '../../models/product_model.dart';
import '../../services/firebase_services.dart';


class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF6B00),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Products',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: Color(0xffFF6B00),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Color(0xff9E9E9E)),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Color(0xff9E9E9E),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                // Category Filter
                StreamBuilder<List<CategoryModel>>(
                  stream: _firebaseService.getCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return SizedBox();

                    final categories = snapshot.data!;
                    return Container(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryChip('All', null),
                          ...categories.map((cat) =>
                              _buildCategoryChip(cat.name, cat.name)
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: _firebaseService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffFF6B00),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No products available',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Filter products
                var products = snapshot.data!
                    .where((product) => product.isInStock)
                    .toList();

                // Apply search filter
                if (_searchQuery.isNotEmpty) {
                  products = products.where((p) =>
                  p.name.toLowerCase().contains(_searchQuery) ||
                      p.sku.toLowerCase().contains(_searchQuery) ||
                      p.category.toLowerCase().contains(_searchQuery)
                  ).toList();
                }

                // Apply category filter
                if (_selectedCategory != null) {
                  products = products
                      .where((p) => p.category == _selectedCategory)
                      .toList();
                }

                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      'No products found',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? value) {
    final isSelected = _selectedCategory == value;
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = value;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isSelected ? Color(0xffFF6B00) : Colors.white,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: product.imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.inventory_2_outlined,
                        size: 50,
                        color: Colors.grey[400],
                      );
                    },
                  ),
                )
                    : Icon(
                  Icons.inventory_2_outlined,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            ),

            // Product Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.category,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xffFF6B00),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}