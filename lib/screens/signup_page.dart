import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'verify_account_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  // Error messages
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _termsError;

  // URL for terms and conditions
  final Uri _termsUrl = Uri.parse('https://pretium.africa/term-of-use');

  Future<void> _launchTermsUrl() async {
    if (!await launchUrl(_termsUrl, mode: LaunchMode.inAppWebView)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'Simplify your crypto payments with us',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),

              const SizedBox(height: 30),

              // First Name Input
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _firstNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _firstNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _firstNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_firstNameError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _firstNameError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // Last Name Input
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _lastNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _lastNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _lastNameError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_lastNameError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _lastNameError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // Email Input
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _emailError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _emailError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _emailError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_emailError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _emailError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // Password Input
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0B6259),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _passwordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                        if (_acceptTerms) {
                          _termsError = null;
                        }
                      });
                    },
                    activeColor: const Color(0xFF0B6259),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side:
                        _termsError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : null,
                  ),
                  TextButton(
                    onPressed: _launchTermsUrl,
                    child: const Text(
                      'Accept Terms and Conditions',
                      style: TextStyle(
                        color: Color(0xFF0B6259),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (_termsError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _termsError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 30),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Reset all errors
                    setState(() {
                      _firstNameError = null;
                      _lastNameError = null;
                      _emailError = null;
                      _passwordError = null;
                      _termsError = null;
                    });

                    // Validate each field
                    bool isValid = true;

                    if (_firstNameController.text.isEmpty) {
                      setState(() {
                        _firstNameError = 'Please enter your first name';
                        isValid = false;
                      });
                    }

                    if (_lastNameController.text.isEmpty) {
                      setState(() {
                        _lastNameError = 'Please enter your last name';
                        isValid = false;
                      });
                    }

                    if (_emailController.text.isEmpty) {
                      setState(() {
                        _emailError = 'Please enter your email';
                        isValid = false;
                      });
                    } else {
                      // Check email format
                      final bool emailValid = RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(_emailController.text);
                      if (!emailValid) {
                        setState(() {
                          _emailError = 'Please enter a valid email';
                          isValid = false;
                        });
                      }
                    }

                    if (_passwordController.text.isEmpty) {
                      setState(() {
                        _passwordError = 'Please enter a password';
                        isValid = false;
                      });
                    } else if (_passwordController.text.length < 6) {
                      setState(() {
                        _passwordError =
                            'Password must be at least 6 characters';
                        isValid = false;
                      });
                    }

                    if (!_acceptTerms) {
                      setState(() {
                        _termsError =
                            'You must accept the terms and conditions';
                        isValid = false;
                      });
                    }

                    // If any validation failed, return early
                    if (!isValid) {
                      return;
                    }

                    // Navigate to verify account page
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyAccountPage(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B6259),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B6259),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
