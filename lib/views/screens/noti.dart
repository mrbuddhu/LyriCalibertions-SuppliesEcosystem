import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool orderUpdates = true;
  bool bookingReminders = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6B2C),
      body: SafeArea(
        child: Column(
          children: [
            // Orange Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Back',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your alerts and preferences',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // White Content Card with Gradient Effect
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFFF6B2C).withOpacity(0.1),
                      Colors.white,
                      Colors.white,
                    ],
                    stops: const [0.0, 0.1, 1.0],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffffe9d9)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order & Booking Notifications Section
                          _buildSectionHeader('Order & Booking Notifications'),
                          const SizedBox(height: 16),

                          _buildToggleItem(
                            title: 'Order Updates',
                            subtitle: 'Get notified about order status changes',
                            value: orderUpdates,
                            onChanged: (value) {
                              setState(() => orderUpdates = value);
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildToggleItem(
                            title: 'Booking Reminders',
                            subtitle: 'Reminders for upcoming appointments',
                            value: bookingReminders,
                            onChanged: (value) {
                              setState(() => bookingReminders = value);
                            },
                          ),

                          const SizedBox(height: 32),

                          // Marketing Notifications Section
                          _buildSectionHeader('Marketing Notifications'),
                          const SizedBox(height: 16),

                          _buildInfoItem(
                            title: 'Promotions & Offers',
                            subtitle: 'Special deals and discounts',
                          ),

                          const SizedBox(height: 16),

                          _buildInfoItem(
                            title: 'New Services',
                            subtitle: 'Updates about new services',
                          ),

                          const SizedBox(height: 32),

                          // Notification Channels Section
                          _buildSectionHeader('Notification Channels'),
                          const SizedBox(height: 16),

                          _buildToggleItem(
                            title: 'Email',
                            subtitle: 'Receive notifications via email',
                            value: emailNotifications,
                            onChanged: (value) {
                              setState(() => emailNotifications = value);
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildToggleItem(
                            title: 'SMS',
                            subtitle: 'Receive notifications via text message',
                            value: smsNotifications,
                            onChanged: (value) {
                              setState(() => smsNotifications = value);
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildToggleItem(
                            title: 'Push Notifications',
                            subtitle: 'Receive push notifications on your device',
                            value: pushNotifications,
                            onChanged: (value) {
                              setState(() => pushNotifications = value);
                            },
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(
      //     color: Colors.grey.shade200,
      //     width: 1,
      //   ),
      // ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFFFF6B2C),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}