import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedService;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    serviceController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffFF6B00),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
        '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xffFF6B00),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

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
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Book a Service',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Schedule your calibration service',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0xff8A8A8A),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Select Service
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.settings,
                                      color: Color(0xffFF6B00), size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Select Service',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                value: selectedService,
                                decoration: InputDecoration(

                                  hintText: 'Choose a service',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xffC0C0C0),
                                  ),
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    BorderSide(color: Color(0xffFF6B00)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                                items: [
                                  'Pressure Gauge Calibration',
                                  'Temperature Sensor Calibration',
                                  'Flow Meter Calibration',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedService = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Preferred Date & Time
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: Color(0xffFF6B00), size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Preferred Date',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: dateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'mm/dd/yyyy',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xffC0C0C0),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today_outlined,
                                      color: Color(0xff8A8A8A), size: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    BorderSide(color: Color(0xffFF6B00)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Preferred Time *',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: timeController,
                                readOnly: true,
                                onTap: () => _selectTime(context),
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: '--:-- --',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xffC0C0C0),
                                  ),
                                  suffixIcon: Icon(Icons.access_time,
                                      color: Color(0xff8A8A8A), size: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    BorderSide(color: Color(0xffFF6B00)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Service Location
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Color(0xffFF6B00), size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Service Location',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: locationController,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Enter your address',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xffC0C0C0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    BorderSide(color: Color(0xffFF6B00)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Additional Notes
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Additional Notes (Optional)',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              TextField(
                                controller: notesController,
                                maxLines: 4,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText:
                                  'Any special requirements or instructions...',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xffC0C0C0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Color(0xffE0E0E0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    BorderSide(color: Color(0xffFF6B00)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        // Booking Summary
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xfffdd3b5),),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                'Booking Summary',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              _buildSummaryRow('Service Fee', '\$150', false),
                              SizedBox(height: 8),
                              _buildSummaryRow('Processing Time', '2-3 days', false),
                              SizedBox(height: 12),
                              Divider(color: Color(0xffE0E0E0)),
                              SizedBox(height: 12),
                              _buildSummaryRow('Total', '\$150', true),
                            ],
                          ),
                        ),
                       
                        SizedBox(height: 30),

                        // Confirm Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle booking confirmation
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffFF6B00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Confirm Booking',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Color(0xff8A8A8A),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Color(0xffFF6B00) : Colors.black,
          ),
        ),
      ],
    );
  }
}