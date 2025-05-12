import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/custom_button.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

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
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(fromPasswordReset: false),
      ),
    );
  }

  void _handleButtonAction() async {
    if (_currentPage == onboardingData.length - 1) {
      // On last page, show loading and go to login
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _navigateToLogin();
      }
    } else {
      // Not on last page, go to next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
            child: CustomButton(
              text:
                  _currentPage == onboardingData.length - 1
                      ? 'Get Started'
                      : 'Next',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              isLoading: _isLoading,
              onPressed: _handleButtonAction,
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
