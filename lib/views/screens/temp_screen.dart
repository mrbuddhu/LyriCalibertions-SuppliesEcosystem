
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SensorCalibrationDetailScreen extends StatelessWidget {
  const SensorCalibrationDetailScreen({Key? key}) : super(key: key);

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
                      Text(
                        'Detail of Sensor Calibrations',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Image.asset("assets/images/temp.png"),

                // Top white card with thermometer icon
                // Container(
                //   width: double.infinity,
                //   color: Colors.white,
                //   padding: const EdgeInsets.symmetric(vertical: 32),
                //   child: Column(
                //     children: [
                //       // Thermometer Icon
                //       Container(
                //         width: 80,
                //         height: 80,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(16),
                //           border: Border.all(color: Colors.grey.shade200, width: 1),
                //         ),
                //         child: Center(
                //           child: Icon(
                //             Icons.thermostat,
                //             size: 50,
                //             color: Colors.orange.shade600,
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       // Rating
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(Icons.star, color: Colors.orange.shade600, size: 18),
                //           const SizedBox(width: 4),
                //           const Text(
                //             '4.6',
                //             style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //           const SizedBox(width: 4),
                //           Text(
                //             '(68 reviews)',
                //             style: TextStyle(
                //               fontSize: 12,
                //               color: Colors.grey.shade600,
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 8),
                //       Text(
                //         'Temperature Instruments',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.grey.shade700,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 16),
                // Main content card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Temperature Sensor\nCalibration',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Price and days
                      Row(
                        children: [
                          const Text(
                            '\$120',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B2C),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16,
                                  color: Colors.grey.shade600
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1-2 days',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Description Section
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Expert calibrations for temperature sensors and thermocouples with full traceability to NIST standards.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Features Section
                      const Text(
                        'Features',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem('NIST traceable calibration'),
                      _buildFeatureItem('Multiple sensor types supported'),
                      _buildFeatureItem('Comprehensive test report'),
                      _buildFeatureItem('Quick 1-2 day service'),
                      _buildFeatureItem('Re-calibration reminders'),
                      const SizedBox(height: 24),
                      // Specifications Section
                      const Text(
                        'Specifications',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSpecRow('Range', '-200°C to 1200°C'),
                      _buildSpecRow('Accuracy', '±0.1°C'),
                      _buildSpecRow('Standards', 'NIST, ISO 17025'),
                      _buildSpecRow('Turnaround', '1-2 business days'),
                      const SizedBox(height: 32),
                      // Bottom Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBottomIcon(Icons.chat_bubble_outline, 'Contact'),
                          _buildBottomIcon(Icons.location_on_outlined, 'Pickup\nAvailable'),
                          _buildBottomIcon(Icons.schedule, 'Delivery'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Book Service Button
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B2C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, size: 20, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Book Service Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: Colors.orange.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.orange.shade600,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}