import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String selectedPeriod = 'Last 30 Days';

  final List<String> periods = [
    'Last 7 Days',
    'Last 30 Days',
    'Last 60 Days',
    'Last 90 Days',
    'Last Year',
    'All Time',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/reportsbg.png",
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Column(
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reports & Analytics",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.menu, color: Colors.black, size: 28),
                  ],
                ),

                const SizedBox(height: 90),


                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                           
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 37,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedPeriod,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    items: periods.map((String period) {
                                      return DropdownMenuItem<String>(
                                        value: period,
                                        child: Text(period),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedPeriod = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                        
                            const SizedBox(width: 12),
                        
                            // Export Button
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 37,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle export functionality
                                    Get.snackbar(
                                      'Export',
                                      'Exporting report...',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      colorText: Colors.white,
                                      margin: EdgeInsets.all(16),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF6B2C),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Export',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                         Image.asset("assets/images/r1.png"),
                              Image.asset("assets/images/r2.png"),
                              SizedBox(height: 10,),
                              Image.asset("assets/images/r3.png"),
                        SizedBox(height: 10,),
                              Image.asset("assets/images/r4.png"),
                        SizedBox(height: 10,),
                              Image.asset("assets/images/r5.png"),
                        SizedBox(height: 10,),
                              Image.asset("assets/images/r6.png"),
                      ],
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}