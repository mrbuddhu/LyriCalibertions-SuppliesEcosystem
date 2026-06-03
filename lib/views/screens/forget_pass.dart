

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/views/screens/otp.dart';

import '../../helpers/mycolors.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController forgetcntrler = TextEditingController();
  final FocusNode forget = FocusNode();
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 50,),
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

                SizedBox(height: 110,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Forget Your",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 5,),
                    Text("Password ?",style: GoogleFonts.poppins(
                        color: AppColors.btncolororg,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),),

                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "Enter your email or phone number for the verification process, we will send 4 digits code.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Color(0xff8A8A8A),
                  ),
                ),
                SizedBox(height: 30,),

                _buildTextField(
                  controller: forgetcntrler,
                  focusNode: forget,
                  label: "Email or Phone Number",
                  hint: "azhar@gmail.com",
                ),
                SizedBox(height: 80,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(Otp());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btncolororg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Send ",
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
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
  }) {
    bool isFocused = focusNode.hasFocus;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isFocused ? AppColors.btncolororg : Color(0xff8A8A8A),
        ),
        floatingLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isFocused ? AppColors.btncolororg : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Color(0xffC0C0C0),
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xffE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xffE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.btncolororg, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
