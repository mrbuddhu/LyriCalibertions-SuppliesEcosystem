
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyri_calibration/helpers/databse_constants.dart';
import 'package:lyri_calibration/helpers/mycolors.dart';
import 'package:lyri_calibration/views/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference database = FirebaseDatabase.instance.ref();


  final TextEditingController usercontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  bool _isPasswordVisible = false;
  bool loading = false;


  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode email = FocusNode();
  final FocusNode phone = FocusNode();


  @override
  void initState() {
    super.initState();

    _usernameFocus.addListener(() {
      setState(() {});
    });
    _passwordFocus.addListener(() {
      setState(() {});
    });
    
    email.addListener((){
      setState(() {
        
      });
    });
    phone.addListener((){
      setState(() {
        
      });
    });
  }
  
  
  
  Future<void> createaccount ()async {
    if(usercontroller.text.trim().isEmpty){
      Get.snackbar("Error", "Please enter username",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if(phonecontroller.text.trim().isEmpty){
      Get.snackbar("Error", "Please enter phone number",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if(emailcontroller.text.trim().isEmpty){
      Get.snackbar("Error", "Please enter email",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (passcontroller.text.trim().isEmpty || passcontroller.text.length < 8) {
      Get.snackbar("Error", "Password must be at least 8 characters",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() {
      loading =true;
    });

   try{

     UserCredential userCredential = await auth.createUserWithEmailAndPassword(

         email: emailcontroller.text.trim(),
         password: passcontroller.text.trim(),
     );

     String uid = userCredential.user!.uid;

     await database.child(DbTables.users).child(uid).set({
       UserKeys.username : usercontroller.text.trim(),
       UserKeys.email : emailcontroller.text.trim(),
       UserKeys.phone : phonecontroller.text.trim(),
       UserKeys.createdAt : DateTime.now().toString(),
       "userId" : uid,
     });

     setState(() {
       loading = false;
     });
     Get.snackbar("Success", "Account created successfully!",
         backgroundColor: Colors.green, colorText: Colors.white);
     Get.off(() => Login());
   } on FirebaseAuthException catch (e) {
     setState(() {
       loading = false;
     });

     String errorMessage = '';
     if (e.code == 'weak-password') {
       errorMessage = 'The password is too weak.';
     } else if (e.code == 'email-already-in-use') {
       errorMessage = 'This email is already registered.';
     } else if (e.code == 'invalid-email') {
       errorMessage = 'Invalid email address.';
     } else {
       errorMessage = 'Error: ${e.message}';
     }

     Get.snackbar("Error", errorMessage,
         backgroundColor: Colors.red, colorText: Colors.white);
   } catch (e) {
     setState(() {
       loading = false;
     });
     Get.snackbar("Error", "Something went wrong. Please try again.",
         backgroundColor: Colors.red, colorText: Colors.white);
   }


   }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Splashbg.png",
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
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Create",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 5,),
                    Text("Account",style: GoogleFonts.poppins(
                        color: AppColors.btncolororg,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),),

                  ],
                ),
                Text("Create your account to get started ",style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xff8A8A8A)
                ),),
                SizedBox(height: 50,),
                _buildTextField(
                  controller: usercontroller,
                  focusNode: _usernameFocus,
                  label: "Username",
                  hint: "XYZ",
                ),
                SizedBox(height: 20,),
                _buildTextField(
                  controller: phonecontroller,
                  focusNode: phone,
                  label: "Phone Number",
                  hint: "03007846476",
                ),
                SizedBox(height: 20,),
                _buildTextField(
                  controller: emailcontroller,
                  focusNode: email,
                  label: "Email Address",
                  hint: "abc@gmail.com",
                ),
               SizedBox(height: 20,),
               _buildPasswordField(),

                SizedBox(height: 20),


                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      loading ? null : createaccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btncolororg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Create Account",
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
                      "Already Have An Account - ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xff8A8A8A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Login());

                      },
                      child: Text(
                        "Login",
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


  Widget _buildPasswordField() {
    bool isFocused = _passwordFocus.hasFocus;

    return TextField(
      controller: passcontroller,
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
        fillColor: Colors.white,
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


}
