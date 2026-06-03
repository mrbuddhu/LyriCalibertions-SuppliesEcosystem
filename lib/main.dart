import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:lyri_calibration/views/screens/splash.dart';

import 'helpers/const_values.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Stripe.publishableKey = stipePublicKey;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lyri Calibrations',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Splash()
    );
  }
}


