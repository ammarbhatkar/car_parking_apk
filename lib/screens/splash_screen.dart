import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'resourcses/images/Animated.svg',
              color: Colors.grey[300],
              fit: BoxFit
                  .cover, // Ensures the background image covers the screen
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  height: 120,
                  width: 120,
                  'resourcses/images/Logo.svg',
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
