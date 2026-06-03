


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? expandedFaqIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I book a service?',
      'answer': 'To book a service, browse our services catalog, select the service you need, choose your preferred date and time, and confirm your booking.'
    },
    {
      'question': 'Can I cancel or reschedule my booking?',
      'answer': 'Yes, you can cancel or reschedule your booking up to 24 hours before the scheduled time through the My Bookings section.'
    },
    {
      'question': 'What payment methods do you accept?',
      'answer': 'We accept credit/debit cards, PayPal, bank transfers, and various digital payment methods.'
    },
    {
      'question': 'How do I track my order?',
      'answer': 'You can track your order in the Orders section of the app. You\'ll receive real-time updates on your order status.'
    },
    {
      'question': 'What is your refund policy?',
      'answer': 'We offer full refunds for cancellations made 24 hours before the service. Partial refunds may apply for later cancellations.'
    },
  ];

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
                    'Help & Support',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'We\'re here to help you',
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
                        // Contact Us Section
                        Text(
                          'Contact Us',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Live Chat
                        _buildContactItem(
                          icon: Icons.chat_bubble_outline,
                          title: 'Live Chat',
                          subtitle: 'Chat with our support team',
                          iconColor: const Color(0xFFFF6B2C),
                          iconBgColor: const Color(0xFFFFE9E0),
                        ),

                        const SizedBox(height: 12),

                        // Email Support
                        _buildContactItem(
                          icon: Icons.email_outlined,
                          title: 'Email Support',
                          subtitle: 'support@example.com',
                          iconColor: const Color(0xFFFF6B2C),
                          iconBgColor: const Color(0xFFFFE9E0),
                        ),

                        const SizedBox(height: 12),

                        // Phone Support
                        _buildContactItem(
                          icon: Icons.phone_outlined,
                          title: 'Phone Support',
                          subtitle: '+1 (800) 123-4567',
                          iconColor: const Color(0xFFFF6B2C),
                          iconBgColor: const Color(0xFFFFE9E0),
                        ),

                        const SizedBox(height: 32),

                        // Frequently Asked Questions Section
                        Text(
                          'Frequently Asked Questions',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // FAQ Items
                        ...List.generate(faqs.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildFaqItem(
                              question: faqs[index]['question']!,
                              answer: faqs[index]['answer']!,
                              index: index,
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // View Full Documentation Button
                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              // Handle documentation view
                            },
                            icon: const Icon(
                              Icons.description_outlined,
                              color: Colors.black87,
                              size: 20,
                            ),
                            label: Text(
                              'View Full Documentation',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
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

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBgColor,
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
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
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade400,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required String question,
    required String answer,
    required int index,
  }) {
    final isExpanded = expandedFaqIndex == index;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                expandedFaqIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}