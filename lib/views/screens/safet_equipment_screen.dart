import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyri_calibration/views/screens/checkout_Screens.dart';

class SafetyEquipmentBundleScreen extends StatefulWidget {
  const SafetyEquipmentBundleScreen({Key? key}) : super(key: key);

  @override
  State<SafetyEquipmentBundleScreen> createState() => _SafetyEquipmentBundleScreenState();
}

class _SafetyEquipmentBundleScreenState extends State<SafetyEquipmentBundleScreen> {
  String selectedPackage = 'Premium Package';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
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
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios_new,
                              size: 18, color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 30,),
                      const Text(
                        'Detail of Safety Equipments',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Image.asset("assets/images/temp.png"),




                const SizedBox(height: 1),

                // Main content
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Safety Equipment\nBundle',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Price and stock
                      Row(
                        children: [
                          const Text(
                            '\$299',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF6B2C),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'In Stock',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Select Package Section
                      const Text(
                        'Select Package',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _buildPackageOption('Standard Package', '\$199'),
                      const SizedBox(height: 10),
                      _buildPackageOption('Premium Package', '\$299'),
                      const SizedBox(height: 10),
                      _buildPackageOption('Deluxe Package', '\$499'),

                      const SizedBox(height: 24),

                      // Description Section
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Complete safety equipment package for industrial environments. Includes all essential protective gear meeting OSHA standards.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // What's Included Section
                      const Text(
                        'What\'s Included',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _buildIncludedItem('Hard hat with adjustable suspension'),
                      _buildIncludedItem('Safety glasses with anti-fog coating'),
                      _buildIncludedItem('High-visibility safety vest'),
                      _buildIncludedItem('Cut-resistant work gloves'),
                      _buildIncludedItem('Steel-toe safety boots (size chart)'),
                      _buildIncludedItem('Ear protection with 30 dB rating'),

                      const SizedBox(height: 24),

                      // Specifications Section
                      const Text(
                        'Specifications',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _buildSpecRow('Certification', 'ANSI Z89.1, OSHA compliant'),
                      _buildSpecRow('Size Available', 'S, M, L, XL, 2XL'),
                      _buildSpecRow('Material', 'High-durability synthetic'),
                      _buildSpecRow('Warranty', '1 year manufacturer warranty'),

                      const SizedBox(height: 24),

                      // Quantity Section

                      const SizedBox(height: 12),



                Container(
                width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Text
                      const Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      Row(
                        children: [
                          // Minus Button
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() => quantity--);
                              }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                              ),
                              child: const Icon(Icons.remove, size: 18),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Quantity Number
                          Text(
                            "$quantity",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Plus Button
                          GestureDetector(
                            onTap: () {
                              setState(() => quantity++);
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                              ),
                              child: const Icon(Icons.add, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


          const SizedBox(height: 28),

                      // Bottom Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBottomIcon(Icons.verified_user_outlined, 'Certified'),
                          _buildBottomIcon(Icons.local_shipping_outlined, 'Free Shipping'),
                          _buildBottomIcon(Icons.autorenew, 'Returns'),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(CheckoutFlowScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B2C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                'Add to Cart - \$${selectedPackage == 'Standard Package' ? '199' : selectedPackage == 'Premium Package' ? '299' : '499'}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Buy Now Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageOption(String title, String price) {
    final isSelected = selectedPackage == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B2C) : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF6B2C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.check_circle,
              size: 18,
              color: Colors.orange.shade600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFF6B2C),
            size: 22,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}