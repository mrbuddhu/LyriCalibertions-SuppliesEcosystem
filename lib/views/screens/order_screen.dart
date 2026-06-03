import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD-1234',
      'title': 'Pressure Gauge Calibration',
      'date': 'May 18, 2025',
      'status': 'In Progress',
      'statusColor': Color(0xff2196F3),
      'iconColor': Color(0xff2196F3),
      'icon': Icons.access_time,
      'dateLabel': 'Estimated',
    },
    {
      'orderId': 'ORD-1233',
      'title': 'Temperature Sensor Kit',
      'date': 'May 12, 2025',
      'status': 'Completed',
      'statusColor': Color(0xff4CAF50),
      'iconColor': Color(0xff4CAF50),
      'icon': Icons.check_circle,
      'dateLabel': 'Completed',
    },
    {
      'orderId': 'ORD-1232',
      'title': 'Flow Meter Calibration',
      'date': 'May 20, 2025',
      'status': 'Pending',
      'statusColor': Color(0xffFF6B00),
      'iconColor': Color(0xffFF6B00),
      'icon': Icons.inventory_2,
      'dateLabel': 'Estimated',
    },
    {
      'orderId': 'ORD-1231',
      'title': 'Safety Equipment Bundle',
      'date': 'May 7, 2025',
      'status': 'Completed',
      'statusColor': Color(0xff4CAF50),
      'iconColor': Color(0xff4CAF50),
      'icon': Icons.check_circle,
      'dateLabel': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF3ED),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset("assets/images/reportsbg.png",height: Get.height,width: Get.width,fit: BoxFit.cover,),
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Orders',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Track your calibration and supply orders',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xff8A8A8A),
                        ),
                      ),
                    ],
                  ),
                ),

                // Orders List
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    itemCount: orders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(
                        orderId: order['orderId'],
                        title: order['title'],
                        date: order['date'],
                        status: order['status'],
                        statusColor: order['statusColor'],
                        iconColor: order['iconColor'],
                        icon: order['icon'],
                        dateLabel: order['dateLabel'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String title,
    required String date,
    required String status,
    required Color statusColor,
    required Color iconColor,
    required IconData icon,
    required String dateLabel,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to order details
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black26),
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
            // Icon
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            SizedBox(width: 14),

            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xff8A8A8A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateLabel,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Color(0xff8A8A8A),
                            ),
                          ),
                          Text(
                            date,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xff9E9E9E),
            ),
          ],
        ),
      ),
    );
  }
}