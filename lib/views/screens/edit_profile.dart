import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialData;

  const EditProfileScreen({Key? key, required this.initialData})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  File? _selectedImage;
  String? _existingPhotoUrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(
        text: widget.initialData['fullName'] ?? '');
    emailController = TextEditingController(
        text: widget.initialData['email'] ?? '');
    phoneController = TextEditingController(
        text: widget.initialData['phone'] ?? '');
    addressController = TextEditingController(
        text: widget.initialData['address'] ?? '');
    _existingPhotoUrl = widget.initialData['photoUrl'];
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _saveProfile() async {
    if (fullNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      String? photoUrl = _existingPhotoUrl;

      // Upload new photo if selected
      if (_selectedImage != null) {
        photoUrl =
        await UserService.instance.uploadProfilePicture(_selectedImage!);
      }

      await UserService.instance.saveProfile(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        photoUrl: photoUrl,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully!'),
            backgroundColor: const Color(0xff4CAF50),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6B2C),
      body: SafeArea(
        child: Column(
          children: [
            // ── Orange Header ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 4),
                        Text('Back',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Edit Profile',
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Update your information',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),

            // ── White Content ─────────────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // ── Profile Photo ─────────────────────────
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xffFF6B00),
                                    width: 2),
                                color: const Color(0xFFFFE9E0),
                              ),
                              child: ClipOval(
                                child: _selectedImage != null
                                    ? Image.file(_selectedImage!,
                                    fit: BoxFit.cover)
                                    : (_existingPhotoUrl != null &&
                                    _existingPhotoUrl!.isNotEmpty
                                    ? Image.network(
                                  _existingPhotoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => const Icon(
                                      Icons.person,
                                      color: Color(0xFFFF6B2C),
                                      size: 50),
                                )
                                    : const Icon(Icons.person,
                                    color: Color(0xFFFF6B2C),
                                    size: 50)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B2C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Tap to change photo',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey.shade500)),

                      const SizedBox(height: 28),

                      // ── Fields ────────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffffe9d9)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildTextField(
                                label: 'Full Name',
                                controller: fullNameController,
                                icon: Icons.person_outline),
                            const SizedBox(height: 20),
                            _buildTextField(
                                label: 'Email',
                                controller: emailController,
                                icon: Icons.email_outlined,
                                keyboardType:
                                TextInputType.emailAddress),
                            const SizedBox(height: 20),
                            _buildTextField(
                                label: 'Phone Number',
                                controller: phoneController,
                                icon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone),
                            const SizedBox(height: 20),
                            _buildTextField(
                                label: 'Address',
                                controller: addressController,
                                icon: Icons.location_on_outlined,
                                maxLines: 2),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ── Buttons ───────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _isSaving
                                  ? null
                                  : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14)),
                              ),
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : _saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFFFF6B2C),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14)),
                                elevation: 0,
                              ),
                              child: _isSaving
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5),
                              )
                                  : Text('Save Changes',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon:
            Icon(icon, color: const Color(0xffFF6B00), size: 20),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            filled: true,
            fillColor: const Color(0xffFAFAFA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Color(0xFFFF6B2C), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}