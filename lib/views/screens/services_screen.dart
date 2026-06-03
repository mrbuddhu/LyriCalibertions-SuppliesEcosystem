import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/views/screens/product_Detail_screen.dart';
import 'package:lyri_calibration/views/screens/services_detail_screen.dart';
import '../../models/service_model.dart';
import '../../models/product_model.dart';
import '../../services/firebase_services.dart';

// import 'product_detail_screen.dart';

class ServicesSuppliesScreen extends StatefulWidget {
  const ServicesSuppliesScreen({super.key});

  @override
  State<ServicesSuppliesScreen> createState() => _ServicesSuppliesScreenState();
}

class _ServicesSuppliesScreenState extends State<ServicesSuppliesScreen> {
  bool isCalibrationSelected = true;
  String _searchQuery = '';
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF3ED),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/reportsbg.png",
              height: Get.height,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                // ── Header ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services & Supplies',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 70),

                      // Toggle Buttons
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => isCalibrationSelected = true),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isCalibrationSelected
                                      ? Color(0xffFF6B00)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isCalibrationSelected
                                        ? Color(0xffFF6B00)
                                        : Color(0xffE0E0E0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.build,
                                        color: isCalibrationSelected
                                            ? Colors.white
                                            : Colors.black,
                                        size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Calibration',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isCalibrationSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => isCalibrationSelected = false),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: !isCalibrationSelected
                                      ? Color(0xffFF6B00)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: !isCalibrationSelected
                                        ? Color(0xffFF6B00)
                                        : Color(0xffE0E0E0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/service.png",
                                      color: !isCalibrationSelected
                                          ? Colors.white
                                          : Colors.black,
                                      height: 18,
                                      width: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Supplies',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: !isCalibrationSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Search Bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffE0E0E0)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: Color(0xff9E9E9E), size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                onChanged: (v) =>
                                    setState(() => _searchQuery = v.toLowerCase()),
                                decoration: InputDecoration(
                                  hintText: isCalibrationSelected
                                      ? 'Search services...'
                                      : 'Search supplies...',
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14, color: Color(0xff9E9E9E)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Icon(Icons.tune, color: Colors.black, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Content ──────────────────────────────────────────
                Expanded(
                  child: isCalibrationSelected
                      ? _buildServicesList()
                      : _buildSuppliesList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Services List (Firebase) ─────────────────────────────────────────────
  Widget _buildServicesList() {
    return StreamBuilder<List<ServiceModel>>(
      stream: _firebaseService.getServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(color: Color(0xffFF6B00)));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyState(
              icon: Icons.build_outlined, message: 'No services available');
        }

        var services = snapshot.data!.where((s) => s.isActive).toList();

        if (_searchQuery.isNotEmpty) {
          services = services
              .where((s) => s.name.toLowerCase().contains(_searchQuery))
              .toList();
        }

        if (services.isEmpty) {
          return _buildEmptyState(
              icon: Icons.search_off, message: 'No services match your search');
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: services.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildCalibrationCard(context, services[index]),
        );
      },
    );
  }

  // ── Supplies List (Firebase) ─────────────────────────────────────────────
  Widget _buildSuppliesList() {
    return StreamBuilder<List<ProductModel>>(
      stream: _firebaseService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(color: Color(0xffFF6B00)));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyState(
              icon: Icons.inventory_2_outlined, message: 'No supplies available');
        }

        var products = snapshot.data!;

        if (_searchQuery.isNotEmpty) {
          products = products
              .where((p) => p.name.toLowerCase().contains(_searchQuery))
              .toList();
        }

        if (products.isEmpty) {
          return _buildEmptyState(
              icon: Icons.search_off, message: 'No supplies match your search');
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: products.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildSupplyCard(context, products[index]),
        );
      },
    );
  }

  // ── Calibration Card ─────────────────────────────────────────────────────
  Widget _buildCalibrationCard(BuildContext context, ServiceModel service) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ServiceDetailScreen(service: service)),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffffd1b0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image / Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffFFE9E0),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: service.imageUrl.isNotEmpty
                  ? Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.build, color: Color(0xffFF6B00), size: 24),
              )
                  : Icon(Icons.build, color: Color(0xffFF6B00), size: 24),
            ),
            SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    service.description,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xff8A8A8A)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${service.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFF6B00),
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.access_time,
                          size: 14, color: Color(0xff8A8A8A)),
                      SizedBox(width: 4),
                      Text(
                        '${service.days} day${service.days != 1 ? 's' : ''}',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xff8A8A8A)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff9E9E9E)),
          ],
        ),
      ),
    );
  }

  // ── Supply Card ──────────────────────────────────────────────────────────
  Widget _buildSupplyCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffffd1b0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffFFE9E0),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('assets/images/service.png',
                      color: Color(0xffFF6B00)),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/service.png',
                    color: Color(0xffFF6B00)),
              ),
            ),
            SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.category.isNotEmpty ? product.category : 'Supply',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xff8A8A8A)),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFF6B00),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        product.isInStock ? 'In Stock' : 'Out of Stock',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: product.isInStock
                              ? Color(0xff4CAF50)
                              : Color(0xffE53935),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff9E9E9E)),
          ],
        ),
      ),
    );
  }

  // ── Empty State ──────────────────────────────────────────────────────────
  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(message,
              style:
              GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500])),
        ],
      ),
    );
  }
}