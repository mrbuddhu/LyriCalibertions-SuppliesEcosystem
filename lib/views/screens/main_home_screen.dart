
// main_navigation.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/helpers/mycolors.dart';
import 'package:lyri_calibration/views/screens/booking_Service.dart';
import 'package:lyri_calibration/views/screens/noti.dart';
import 'package:lyri_calibration/views/screens/order_screen.dart';
import 'package:lyri_calibration/views/screens/product_Detail_screen.dart';
import 'package:lyri_calibration/views/screens/product_list_screen.dart';
import 'package:lyri_calibration/views/screens/profile_Screen.dart';
import 'package:lyri_calibration/views/screens/reports.dart';
import 'package:lyri_calibration/views/screens/services_detail_screen.dart';
import 'package:lyri_calibration/views/screens/services_screen.dart';

import '../../models/product_model.dart';
import '../../models/service_model.dart';
import '../../services/firebase_services.dart';
import '../../services/user_service.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ServicesSuppliesScreen(),
    MyOrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, "assets/images/home.png", 'Home'),
                _buildNavItem(1, "assets/images/service.png", 'Services'),
                _buildNavItem(2, "assets/images/order.png", 'Orders'),
                _buildNavItem(3, "assets/images/profile.png", 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
              color: isSelected ? const Color(0xffFF6B00) : const Color(0xff9E9E9E),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected ? const Color(0xffFF6B00) : const Color(0xff9E9E9E),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

}





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService _firebaseService = FirebaseService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Orange Header ──────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFF6B00),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Section
                    Row(
                      children: [
                        // Replace the CircleAvatar in HomeScreen header with this:
                        StreamBuilder<Map<String, dynamic>>(
                          stream: UserService.instance.getProfileStream(),
                          builder: (context, snapshot) {
                            final photoUrl = snapshot.data?['photoUrl'] as String?;
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                color: Colors.white,
                              ),
                              child: ClipOval(
                                child: photoUrl != null && photoUrl.isNotEmpty
                                    ? Image.network(
                                  photoUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Icon(Icons.person, color: Color(0xffFF6B00)),
                                )
                                    : Icon(Icons.person, color: Color(0xffFF6B00)),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  FirebaseAuth.instance.currentUser
                                      ?.displayName ??
                                      'User',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.waving_hand,
                                    color: Colors.yellow, size: 18),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Get.to(NotificationsSettingsScreen());
                            },
                            icon: Icon(Icons.notifications_outlined,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Stats Cards
                    Row(
                      children: [
                        _buildStatCard('3', 'Active Orders'),
                        SizedBox(width: 12),
                        _buildStatCard('12', 'Completed'),
                        SizedBox(width: 12),
                        _buildStatCard('2', 'Pending'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Scrollable Body ────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xffE0E0E0)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Color(0xff9E9E9E)),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Color(0xff9E9E9E),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.tune, color: Colors.black),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),

                    // ── Quick Actions ──────────────────────────────
                    Text(
                      'Quick Actions',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuickAction(
                            'assets/images/h1.png', 'Book Service', () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => BookServiceScreen()));
                        }),
                        _buildQuickAction(
                            'assets/images/h2.png', 'Products', () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsListScreen()));
                        }),
                        _buildQuickAction(
                            'assets/images/h3.png', 'Reports', () {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => Reports()));
                        }),
                        _buildQuickAction(
                            'assets/images/h4.png', 'Support', () {}),
                      ],
                    ),
                    SizedBox(height: 25),

                    // ── Calibration Services (REAL DATA) ──────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calibration Services',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFF6B00),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    StreamBuilder<List<ServiceModel>>(
                      stream: _firebaseService.getServices(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                  color: Color(0xffFF6B00)),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptyState(
                            icon: Icons.build_outlined,
                            message: 'No services available',
                          );
                        }

                        // Show only active services (limit 3 for home preview)
                        final activeServices = snapshot.data!
                            .where((s) => s.isActive)
                            .take(3)
                            .toList();

                        if (activeServices.isEmpty) {
                          return _buildEmptyState(
                            icon: Icons.build_outlined,
                            message: 'No active services right now',
                          );
                        }

                        return Column(
                          children: activeServices
                              .asMap()
                              .entries
                              .map((e) => Padding(
                            padding: EdgeInsets.only(
                                bottom: e.key <
                                    activeServices.length - 1
                                    ? 12
                                    : 0),
                            child: _buildServiceCard(
                                context, e.value),
                          ))
                              .toList(),
                        );
                      },
                    ),
                    SizedBox(height: 25),

                    // ── Featured Supplies (REAL DATA) ──────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Supplies',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsListScreen()));
                          },
                          child: Text(
                            'View All',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFF6B00),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    StreamBuilder<List<ProductModel>>(
                      stream: _firebaseService.getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                  color: Color(0xffFF6B00)),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptyState(
                            icon: Icons.inventory_2_outlined,
                            message: 'No products available',
                          );
                        }

                        final featuredProducts = snapshot.data!
                            .where((p) => p.isInStock)
                            .take(4)
                            .toList();

                        if (featuredProducts.isEmpty) {
                          return _buildEmptyState(
                            icon: Icons.inventory_2_outlined,
                            message: 'No products in stock',
                          );
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: featuredProducts.length,
                          itemBuilder: (context, index) {
                            return _buildProductCard(
                                context, featuredProducts[index]);
                          },
                        );
                      },
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

  // ── Service Card (tappable, real data) ──────────────────────────────────
  Widget _buildServiceCard(BuildContext context, ServiceModel service) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailScreen(service: service),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image / Icon
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xfff2e2d8),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: service.imageUrl.isNotEmpty
                  ? Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.build,
                    color: Color(0xffFF6B00)),
              )
                  : Icon(Icons.build, color: Color(0xffFF6B00)),
            ),
            SizedBox(width: 12),

            // Name, duration
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
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${service.days} day${service.days != 1 ? 's' : ''} · \$${service.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xff9E9E9E),
                    ),
                  ),
                ],
              ),
            ),

            // Status badge
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff0fdf4),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                'Available',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4CAF50),
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: Color(0xff9E9E9E)),
          ],
        ),
      ),
    );
  }

  // ── Empty State ──────────────────────────────────────────────────────────
  Widget _buildEmptyState(
      {required IconData icon, required String message}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 56, color: Colors.grey[300]),
            SizedBox(height: 12),
            Text(message,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // ── Unchanged helpers ────────────────────────────────────────────────────
  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 4),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9))),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
      String imagePath, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfffeebdc)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xffffe9d9),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(imagePath,
                      fit: BoxFit.contain,
                      height: 15,
                      width: 15,
                      color: Color(0xffFF6B00)),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 70,
              child: Text(label,
                  style:
                  GoogleFonts.poppins(fontSize: 10, color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
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
            Container(
              height: 120,
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
                    height: 120,
                    errorBuilder: (_, __, ___) => Icon(
                        Icons.inventory_2_outlined,
                        size: 50,
                        color: Colors.grey[400]),
                  ),
                )
                    : Icon(Icons.inventory_2_outlined,
                    size: 50, color: Colors.grey[400]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xffFF6B00),
                            shape: BoxShape.circle),
                        child:
                        Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





