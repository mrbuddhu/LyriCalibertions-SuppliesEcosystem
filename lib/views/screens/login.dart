import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/helpers/mycolors.dart';
import 'package:lyri_calibration/views/screens/forget_pass.dart';
import 'package:lyri_calibration/views/screens/main_home_screen.dart';
import 'package:lyri_calibration/views/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool loading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;


  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _usernameFocus.addListener(() {
      setState(() {});
    });
    _passwordFocus.addListener(() {
      setState(() {});
    });
  }


  Future<void> login() async {
    if (emailcontroller.text.trim().isEmpty) {
      Get.snackbar("Missing Email", "Oops! You forgot to enter your email address.",
          backgroundColor: Colors.orange.shade400, colorText: Colors.white);
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      Get.snackbar("Missing Password", "Please enter your password to continue.",
          backgroundColor: Colors.orange.shade400, colorText: Colors.white);
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await auth.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        loading = false;
      });
      Get.snackbar("Welcome Back! 👋", "You've successfully logged in.",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(() => MainNavigation());

    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });

      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No account found with this email. Please sign up first.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please double-check and try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'That doesn\'t look like a valid email address.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This account has been disabled. Please contact support.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many failed attempts. Please wait a moment and try again.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'No internet connection. Please check your network and retry.';
      } else {
        errorMessage = 'Something went wrong: ${e.message}';
      }

      Get.snackbar("Login Failed", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);

    } catch (e) {
      setState(() {
        loading = false;
      });
      Get.snackbar("Unexpected Error", "Something went wrong on our end. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


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
          SingleChildScrollView(
            child: Padding(
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

                  SizedBox(height: 20),


                  Image.asset("assets/images/logintexttop.png"),

                  SizedBox(height: 30),


                  Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: AppColors.btncolororg,
                    ),
                  ),

                  SizedBox(height: 10),


                  Text(
                    "Login to your account",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xff8A8A8A),
                    ),
                  ),

                  SizedBox(height: 30),


                  _buildTextField(
                    controller: emailcontroller,
                    focusNode: _usernameFocus,
                    label: "Email",
                    hint: "Azhar01@gmail.com",
                  ),

                  SizedBox(height: 20),

                  _buildPasswordField(),

                  SizedBox(height: 10),


                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(ForgetPass());

                      },
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: loading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: loading ? Colors.orange.shade200 : AppColors.btncolororg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: loading
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Logging in...",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),


                  Text(
                    "or continue with",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0xff8A8A8A),
                    ),
                  ),

                  SizedBox(height: 20),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: Icons.apple,
                        onTap: () {
                          // Handle Apple login
                        },
                      ),
                      SizedBox(width: 15),
                      _buildSocialButton(
                        iconPath: "assets/images/google.png",
                        onTap: () {

                        },
                      ),
                      SizedBox(width: 15),
                      _buildSocialButton(
                        iconPath: "assets/images/facebook.png",
                        onTap: () {

                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 30),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have An Account - ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xff8A8A8A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(Signup());

                        },
                        child: Text(
                          "Signup",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.btncolororg,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
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


  Widget _buildPasswordField() {
    bool isFocused = _passwordFocus.hasFocus;

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      obscureText: !_isPasswordVisible,
      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isFocused ? AppColors.btncolororg : Color(0xff8A8A8A),
        ),
        floatingLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isFocused ? AppColors.btncolororg : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        hintText: "••••••••••••••••",
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
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
            size: 20,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }


  Widget _buildSocialButton({
    IconData? icon,
    String? iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xffE0E0E0)),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 28, color: Colors.black)
              : Image.asset(iconPath!, height: 24, width: 24),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}