

// lib/screens/user/service_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/service_model.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          CustomScrollView(
            slivers: [
              // App Bar with Image
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Color(0xffFF6B00),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.black87),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: service.imageUrl.isNotEmpty
                      ? Image.network(
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildImagePlaceholder(),
                  )
                      : _buildImagePlaceholder(),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Status Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              service.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: service.isActive
                                  ? Color(0xfff0fdf4)
                                  : Color(0xfffff1f1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              service.isActive ? 'Available' : 'Unavailable',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: service.isActive
                                    ? Color(0xff4CAF50)
                                    : Color(0xffE53935),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Price + Duration Row
                      Row(
                        children: [
                          _buildInfoChip(
                            icon: Icons.attach_money,
                            label: '\$${service.price.toStringAsFixed(2)}',
                            color: Color(0xffFF6B00),
                            bgColor: Color(0xfffff3e8),
                          ),
                          SizedBox(width: 12),
                          _buildInfoChip(
                            icon: Icons.access_time_outlined,
                            label: '${service.days} day${service.days != 1 ? 's' : ''}',
                            color: Color(0xff1565C0),
                            bgColor: Color(0xffe8f0fe),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Description
                      Text(
                        'About This Service',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        service.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xff616161),
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Features
                      if (service.features.isNotEmpty) ...[
                        Text(
                          'Features',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        ...service.features.map(
                              (feature) => _buildListItem(
                            feature,
                            iconColor: Color(0xffFF6B00),
                            iconBg: Color(0xfffff3e8),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],

                      // Specifications
                      if (service.specifications.isNotEmpty) ...[
                        Text(
                          'Specifications',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        ...service.specifications.map(
                              (spec) => _buildListItem(
                            spec,
                            iconColor: Color(0xff1565C0),
                            iconBg: Color(0xffe8f0fe),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Book Now Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Price summary
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xff9E9E9E),
                        ),
                      ),
                      Text(
                        '\$${service.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  // Book Now Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: service.isActive
                          ? () => _showBookingSheet(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF6B00),
                        disabledBackgroundColor: Colors.grey[300],
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        service.isActive ? 'Book Now' : 'Not Available',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Color(0xffffe9d9),
      child: Center(
        child: Icon(Icons.build_outlined, size: 80, color: Color(0xffFF6B00)),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text,
      {required Color iconColor, required Color iconBg}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(Icons.check, size: 12, color: iconColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xff424242),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BookingSheet(service: service),
    );
  }
}

// ─── Booking Bottom Sheet ───────────────────────────────────────────────────

class _BookingSheet extends StatefulWidget {
  final ServiceModel service;
  const _BookingSheet({required this.service});

  @override
  State<_BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<_BookingSheet> {
  DateTime? _selectedDate;
  final _notesController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(Duration(days: 1)),
      firstDate: now.add(Duration(days: 1)),
      lastDate: now.add(Duration(days: 90)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Color(0xffFF6B00)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _confirmBooking() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a preferred date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // TODO: Save booking to Firebase here
    await Future.delayed(Duration(seconds: 1)); // Simulate network call

    setState(() => _isSubmitting = false);
    Navigator.pop(context); // close sheet

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking request submitted successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Book Service',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.service.name,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Color(0xff9E9E9E)),
            ),
            SizedBox(height: 24),

            // Summary Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xfffff8f2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xffffddbb)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _summaryItem(
                        'Price', '\$${widget.service.price.toStringAsFixed(2)}'),
                  ),
                  Container(width: 1, height: 36, color: Color(0xffffddbb)),
                  Expanded(
                    child: _summaryItem(
                        'Duration', '${widget.service.days} days'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Date Picker
            Text(
              'Preferred Start Date',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedDate != null
                        ? Color(0xffFF6B00)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        color: Color(0xffFF6B00), size: 20),
                    SizedBox(width: 12),
                    Text(
                      _selectedDate == null
                          ? 'Select a date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: _selectedDate == null
                            ? Color(0xff9E9E9E)
                            : Colors.black87,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Notes
            Text(
              'Additional Notes (Optional)',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Any special requirements or notes...',
                hintStyle: GoogleFonts.poppins(
                    fontSize: 13, color: Color(0xff9E9E9E)),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffFF6B00)),
                ),
              ),
            ),
            SizedBox(height: 28),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF6B00),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
                    : Text(
                  'Confirm Booking',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String value) {
    return Column(
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 12, color: Color(0xff9E9E9E))),
        SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF6B00))),
      ],
    );
  }
}