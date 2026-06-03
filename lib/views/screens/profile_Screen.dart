import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/user_service.dart';
import 'edit_profile.dart';
import 'help_and_support.dart';
import 'login.dart';
import 'noti.dart';
import 'setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: UserService.instance.getProfileStream(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};
          final fullName = data['fullName'] ??
              FirebaseAuth.instance.currentUser?.displayName ??
              'User';
          final email = data['email'] ??
              FirebaseAuth.instance.currentUser?.email ??
              '';
          final phone = data['phone'] ?? '';
          final address = data['address'] ?? '';
          final photoUrl = data['photoUrl'] as String?;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Orange Header with avatar ─────────────────────
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffFF6B00),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
                      child: Column(
                        children: [
                          // ── Top bar ──────────────────────────
                          Row(
                            children: [
                              Text(
                                'My Profile',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Get.to(
                                  EditProfileScreen(initialData: data),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                        Colors.white.withOpacity(0.4)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.edit,
                                          color: Colors.white, size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Edit Profile',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ── Avatar ───────────────────────────
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: photoUrl != null && photoUrl.isNotEmpty
                                  ? Image.network(
                                photoUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _placeholderAvatar(),
                              )
                                  : _placeholderAvatar(),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Name
                          Text(
                            fullName,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.email_outlined,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 13),
                              const SizedBox(width: 5),
                              Text(
                                email.isNotEmpty ? email : 'No email set',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ── Stats Row ─────────────────────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem('15', 'Orders'),
                                _buildDivider(),
                                _buildStatItem('3', 'Active'),
                                _buildDivider(),
                                _buildStatItem('\$2.4K', 'Spent'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Profile Information Card ──────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFF0E6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Color(0xffFF6B00),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Profile Information',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Divider(
                            height: 1,
                            color: Color(0xffF0F0F0),
                            thickness: 1),
                        const SizedBox(height: 8),

                        // Info rows
                        _buildInfoTile(
                          icon: Icons.person_outline,
                          label: 'Full Name',
                          value: fullName,
                        ),
                        _buildInfoTile(
                          icon: Icons.email_outlined,
                          label: 'Email Address',
                          value: email.isNotEmpty ? email : 'Not set',
                        ),
                        _buildInfoTile(
                          icon: Icons.phone_outlined,
                          label: 'Phone Number',
                          value: phone.isNotEmpty ? phone : 'Not set',
                        ),
                        _buildInfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: address.isNotEmpty ? address : 'Not set',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Menu Items ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          subtitle: 'Manage your alerts',
                          onTap: () =>
                              Get.to(NotificationsSettingsScreen()),
                          isFirst: true,
                        ),
                        _buildDividerLine(),
                        _buildMenuItem(
                          icon: Icons.credit_card_outlined,
                          title: 'Payment Methods',
                          subtitle: 'Manage saved cards',
                          onTap: () {},
                        ),
                        _buildDividerLine(),
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: 'Booking History',
                          subtitle: 'View your past orders',
                          onTap: () {},
                        ),
                        _buildDividerLine(),
                        _buildMenuItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          subtitle: 'App preferences',
                          onTap: () => Get.to(SettingsScreen()),
                        ),
                        _buildDividerLine(),
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          subtitle: 'Get assistance',
                          onTap: () => Get.to(HelpSupportScreen()),
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Logout Button ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(Login());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF1F1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xffFFCDD2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded,
                              color: Color(0xffE53935), size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffE53935),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _placeholderAvatar() {
    return Container(
      color: Colors.white.withOpacity(0.3),
      child: const Icon(Icons.person, color: Colors.white, size: 50),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 36,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffFFF0E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xffFF6B00), size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xffAAAAAA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xffF8F8F8),
            indent: 74,
            endIndent: 20,
          ),
      ],
    );
  }

  Widget _buildDividerLine() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xffF8F8F8),
      indent: 74,
      endIndent: 20,
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isFirst ? 20 : 0),
            topRight: Radius.circular(isFirst ? 20 : 0),
            bottomLeft: Radius.circular(isLast ? 20 : 0),
            bottomRight: Radius.circular(isLast ? 20 : 0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xffFFF0E6),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              Icon(icon, color: const Color(0xffFF6B00), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xff9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 13, color: Color(0xff9E9E9E)),
            ),
          ],
        ),
      ),
    );
  }
}