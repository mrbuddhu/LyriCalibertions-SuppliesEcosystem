import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/helpers/mycolors.dart';
import 'package:lyri_calibration/views/screens/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navigate to Login screen when on the third page
      Get.to(() => Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          children: [
            _buildPage(
              image: 'assets/images/on11.png',
              title: 'Professional ',
              highlight: 'Calibration',
              desc:
              'Expert calibration services for all your industrial equipment with certified precision.',
            ),
            _buildPage(
              image: 'assets/images/on22.png',
              title: 'Industrial ',
              highlight: 'Supplies',
              desc:
              'High-quality supplies and equipment delivered to your doorstep with fast shipping.',
            ),
            _buildPage(
              image: 'assets/images/on33.png',
              title: 'Trusted & ',
              highlight: 'Reliable',
              desc:
              'ISO certified services with comprehensive warranties and ongoing support.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String highlight,
    required String desc,
  }) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 70),

          /// IMAGE CARD
          Container(
            height: 360,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// TITLE
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: title,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: highlight,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.btncolororg)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(desc,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey, height: 1.5)),
          ),

          SizedBox(
            height: 50,
          ),

          /// GET START BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btncolororg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Get Start',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already Have An Account - ',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => Login()); // Fixed: Added arrow function
                },
                child: Text('Login',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.btncolororg)),
              ),
            ],
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}