import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool biometricLogin = false;
  bool autoBackup = true;
  String selectedLanguage = 'English';
  String selectedCurrency = 'USD (\$)';

  final List<String> languages = ['English', 'Spanish', 'French', 'German', 'Arabic'];
  final List<String> currencies = ['USD (\$)', 'EUR (€)', 'GBP (£)', 'PKR (₨)'];

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
                    'Settings',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'App preferences and configuration',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Appearance Section
                        _buildSectionHeader('Appearance'),
                        const SizedBox(height: 16),

                        _buildToggleItem(
                          title: 'Dark Mode',
                          subtitle: 'Enable dark theme',
                          value: darkMode,
                          onChanged: (value) {
                            setState(() => darkMode = value);
                          },
                        ),

                        const SizedBox(height: 32),

                        // Security Section
                        _buildSectionHeader('Security'),
                        const SizedBox(height: 16),

                        _buildToggleItem(
                          title: 'Biometric Login',
                          subtitle: 'Use fingerprint or face ID',
                          value: biometricLogin,
                          onChanged: (value) {
                            setState(() => biometricLogin = value);
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildToggleItem(
                          title: 'Auto Backup',
                          subtitle: 'Backup data automatically',
                          value: autoBackup,
                          onChanged: (value) {
                            setState(() => autoBackup = value);
                          },
                        ),

                        const SizedBox(height: 32),

                        // Preferences Section
                        _buildSectionHeader('Preferences'),
                        const SizedBox(height: 16),

                        // Language Dropdown
                        _buildDropdownField(
                          label: 'Language',
                          value: selectedLanguage,
                          items: languages,
                          onChanged: (value) {
                            setState(() => selectedLanguage = value!);
                          },
                        ),

                        const SizedBox(height: 16),

                        // Currency Dropdown
                        _buildDropdownField(
                          label: 'Currency',
                          value: selectedCurrency,
                          items: currencies,
                          onChanged: (value) {
                            setState(() => selectedCurrency = value!);
                          },
                        ),

                        const SizedBox(height: 24),
                      ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
                size: 24,
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}