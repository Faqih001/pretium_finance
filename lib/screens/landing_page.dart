import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_pa          SmoothPageIndicator(
            controller: _pageController,
            count: onboardingData.length,
            effect: const WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotHeight: 12,
              activeDotWidth: 32,
              activeDotColor: Color(0xFF0B6259),
              dotColor: Color(0xFFDDDDDD),
            ),
          ),or.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();

  List<OnboardingData> onboardingData = [
    OnboardingData(
      title: 'Direct Pay',
      description: 'Pay with crypto across Africa effortlessly',
      icon: Icons.credit_card,
    ),
    OnboardingData(
      title: 'Accept Payments',
      description: 'Accept stable coin payments hasstle-free',
      icon: Icons.account_balance_wallet,
    ),
    OnboardingData(
      title: 'Pay Bills',
      description: 'Pay for utility services and earn rewards',
      icon: Icons.receipt,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {});
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _navigateToLogin,
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF757575),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: onboardingData[index].title,
                  description: onboardingData[index].description,
                  icon: onboardingData[index].icon,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SmoothPageIndicator(
            controller: _pageController,
            count: onboardingData.length,
            effect: const WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotColor: Color(0xFF0B6259),
              dotColor: Color(0xFFDDDDDD),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _navigateToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B6259),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4F4),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(icon, size: 50, color: const Color(0xFF0B6259)),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF757575),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
