import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/views/screens/success_pass.dart';
import 'package:pinput/pinput.dart';

import '../../helpers/mycolors.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE0E0E0)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.btncolororg, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
        border: Border.all(color: AppColors.btncolororg),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/onbg.png",
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Verify",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Code",
                      style: GoogleFonts.poppins(
                        color: AppColors.btncolororg,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Please enter the code we just send to email\nzeel2@email.com",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xff8A8A8A),
                  ),
                ),
                SizedBox(height: 40),
                Pinput(
                  controller: otpController,
                  focusNode: otpFocusNode,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  onCompleted: (pin) {
                    // Handle OTP completion
                    print('OTP Completed: $pin');
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive OTP? ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xff8A8A8A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle resend code
                        print('Resend code clicked');
                      },
                      child: Text(
                        "Resend code",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(SuccessPass());
                      if (otpController.text.length == 4) {
                        print('Verifying OTP: ${otpController.text}');
                        // Add your verification logic here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btncolororg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Verify",
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
          )
        ],
      ),
    );
  }
}