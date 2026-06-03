import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyri_calibration/views/screens/on_boarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;

  @override
  void initState() {
    super.initState();

    // First image animation controller
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Second image animation controller with delay
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Scale animation for first image (starts from 0.0 and goes to 1.0)
    _scaleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeOutBack),
    );

    // Scale animation for second image (starts from 0.0 and goes to 1.0)
    _scaleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeOutBack),
    );

    // Start first animation immediately
    _controller1.forward();

    // Start second animation after first one completes
    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      }
    });


    Future.delayed(Duration(seconds: 3), (){
      if(mounted){
       Get.off(OnboardingScreen());
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
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
          Center(
            child: Column(
              children: [
                const SizedBox(height: 120),

                // First image with scale animation (zoom out to zoom in)
                ScaleTransition(
                  scale: _scaleAnimation1,
                  child: Image.asset(
                    "assets/images/splash1.png",
                    width: Get.width - 50,
                  ),
                ),

                const SizedBox(height: 280),

                // Second image with scale animation (zoom out to zoom in)
                ScaleTransition(
                  scale: _scaleAnimation2,
                  child: Image.asset(
                    "assets/images/splash2.png",
                    width: Get.width - 50,
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