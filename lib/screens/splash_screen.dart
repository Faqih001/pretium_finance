import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/landing_page.dart';
import '../screens/enter_pin_page.dart';
import '../services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
  
  Future<void> _checkLoginStatus() async {
    // Add a slight delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 3));
    
    // Check if user is logged in and has PIN
    final isLoggedIn = await StorageService.getLoginStatus();
    final hasPin = await StorageService.hasPin();
    
    if (mounted) {
      // Navigate based on login and PIN status
      if (isLoggedIn && hasPin) {
        // If logged in and has PIN, go to PIN entry screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EnterPinPage()),
        );
      } else {
        // Otherwise go to onboarding/landing
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0B6666,
      ), // Teal color as seen in the image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 170,
              width: 170,
              child: Image.asset(
                'assets/pretium_logo.png'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
