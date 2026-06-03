import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutFlowScreen extends StatefulWidget {
  const CheckoutFlowScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutFlowScreen> createState() => _CheckoutFlowScreenState();
}

class _CheckoutFlowScreenState extends State<CheckoutFlowScreen> {
  int currentStep = 0; // 0: Shipping, 1: Payment, 2: Confirmation, 3: Order Confirmed
  String selectedPaymentMethod = 'Credit / Debit Card';
  bool showAddCardDialog = false;

  // Form controllers
  final TextEditingController fullNameController = TextEditingController(text: 'Azhar ud din');
  final TextEditingController emailController = TextEditingController(text: 'azharuddin@gmail.com');
  final TextEditingController streetController = TextEditingController(text: 'Un street 2132');
  final TextEditingController cityController = TextEditingController(text: 'United Stat');
  final TextEditingController stateController = TextEditingController(text: '**********');
  final TextEditingController zipController = TextEditingController(text: '18002');
  final TextEditingController countryController = TextEditingController(text: 'United States');

  // Card form controllers
  final TextEditingController cardNumberController = TextEditingController(text: '1324435845868788568578');
  final TextEditingController cardHolderController = TextEditingController(text: 'Azhar');
  final TextEditingController streetAddressController = TextEditingController(text: 'Un street 2132');
  final TextEditingController expirationController = TextEditingController(text: 'MM/YY');
  final TextEditingController cvvController = TextEditingController(text: '**********');

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
          Column(
            children: [
              SizedBox(height: 70),
              Text(
                "Checkout",
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 80),

              // Progress Indicator with Lines
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                  children: [
                    _buildStepIndicator(0, 'Shipping'),
                    _buildStepIndicator(1, 'Payment'),
                    _buildStepIndicator(2, 'Confirmation'),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: currentStep == 0
                      ? _buildShippingAddress()
                      : currentStep == 1
                      ? _buildPaymentMethod()
                      : currentStep == 2
                      ? _buildConfirmation()
                      : _buildOrderConfirmed(),
                ),
              ),
            ],
          ),

          // Add Card Dialog Overlay
          if (showAddCardDialog) _buildAddCardDialog(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    final isActive = currentStep == step;
    final isCompleted = currentStep > step;

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              // Left line
              if (step > 0)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? const Color(0xFFFF6B2C) : Colors.grey.shade300,
                  ),
                ),

              // Circle with number
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive || isCompleted ? const Color(0xFFFF6B2C) : Colors.white,
                  border: Border.all(
                    color: isActive || isCompleted ? const Color(0xFFFF6B2C) : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${step + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isActive || isCompleted ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),

              // Right line
              if (step < 2)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? const Color(0xFFFF6B2C) : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.black : Colors.grey.shade500,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddress() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffffe9d9))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField('Full Name', fullNameController),
          const SizedBox(height: 16),
          _buildTextField('Email', emailController),
          const SizedBox(height: 16),
          _buildTextField('Street Address', streetController),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('City', cityController)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('State', stateController)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('ZIP Code', zipController)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('Country', countryController)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() => currentStep = 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue to Payment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFooterIcons(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Credit/Debit Card Option
          _buildPaymentOption(
            'Credit / Debit Card',
            'Visa, Mastercard, Apple Pay, Google Pay',
            Icons.credit_card,
            true,
          ),
          const SizedBox(height: 12),

          // PayPal Option
          _buildPaymentOption(
            'PayPal',
            'Pay with your PayPal account',
            Icons.paypal,
            false,
          ),
          const SizedBox(height: 12),

          // Bank Transfer Option
          _buildPaymentOption(
            'Bank Transfer',
            'Direct bank transfer',
            Icons.account_balance,
            false,
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() => currentStep = 0);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => showAddCardDialog = true);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFFFF6B2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Complete Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFooterIcons(),
        ],
      ),
    );
  }

  Widget _buildConfirmation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Review your order',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() => currentStep = 3);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B2C),
            ),
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderConfirmed() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4CAF50),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Order Confirmed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your order has been successfully placed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),

          // Order Number
          _buildInfoRow('Order Number', 'ORD-1761913173015'),
          const Divider(height: 32),

          // Shipping Address
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'London\nItaly\nUn. Dev street\nUnited States',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.6,
              ),
            ),
          ),
          const Divider(height: 32),

          // Payment Method
          _buildInfoRow('Payment Method', 'Credit/Debit Card'),
          const Divider(height: 32),

          // Order Total
          _buildInfoRow('Order Total', '\$1114.87', isTotal: true),
          const SizedBox(height: 24),

          const Text(
            'A confirmation email has been sent to\nazharuddin840@gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to home or orders
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Confirmed Shopping',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardDialog() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() => showAddCardDialog = false);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'Add New Card',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => showAddCardDialog = false);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildTextField('Card Number', cardNumberController),
                const SizedBox(height: 16),
                _buildTextField('Card Holder Name', cardHolderController),
                const SizedBox(height: 16),
                _buildTextField('Street Address', streetAddressController),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField('Expiration Date', expirationController),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField('CVV', cvvController),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() => showAddCardDialog = false);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAddCardDialog = false;
                            currentStep = 3;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFFFF6B2C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Complete Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildFooterIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFFF6B2C)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPaymentMethod = title);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF4EF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B2C) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFE5D9) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFFFF6B2C) : Colors.grey.shade600,
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
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFFFF6B2C) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF6B2C) : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? const Color(0xFFFF6B2C) : Colors.white,
              ),
              child: isSelected ? const Icon(Icons.circle, color: Colors.white, size: 12) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_outline, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(
          'SSL Encrypted',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 16),
        Icon(Icons.verified_user_outlined, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(
          'Secure Checkout',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 16),
        Icon(Icons.card_giftcard, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(
          'PCI Compliant',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFFFF6B2C) : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    streetAddressController.dispose();
    expirationController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}