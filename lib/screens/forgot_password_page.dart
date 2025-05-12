import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../widgets/custom_button.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  String? _emailError;
  bool _isLoading = false;

  // Method to navigate to reset password page
  void _navigateToResetPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(email: _emailController.text),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                'Forgot Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 12),

              // Instruction text
              const Text(
                'Enter your email to receive a password reset code',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),

              const SizedBox(height: 40),

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

              const SizedBox(height: 40),

              // Send Reset Code Button
              CustomButton(
                text: 'Send Reset Code',
                isLoading: _isLoading,
                onPressed: () async {
                  // Validate email
                  setState(() {
                    _emailError = null; // Reset error
                  });

                  if (_emailController.text.isEmpty) {
                    setState(() {
                      _emailError = 'Please enter your email';
                    });
                    return;
                  }

                  // Check for valid email format
                  final bool emailValid = RegExp(
                    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(_emailController.text);
                  if (!emailValid) {
                    setState(() {
                      _emailError = 'Please enter a valid email';
                    });
                    return;
                  }

                  // Show loading indicator
                  setState(() {
                    _isLoading = true;
                  });

                  // Check if email exists in our stored users
                  final userData = await StorageService.getUserData();
                  if (userData != null &&
                      userData['email'] == _emailController.text) {
                    // Save password reset request
                    await StorageService.savePasswordResetRequest(
                      _emailController.text,
                    );

                    // Get reset code (in a real app, this would be sent via email)
                    await StorageService.getPasswordResetRequest();
                    
                    // Simulate network delay
                    await Future.delayed(const Duration(milliseconds: 1500));

                    // Reset loading state
                    setState(() {
                      _isLoading = false;
                    });

                    if (mounted) {
                      // Show success dialog with the reset code
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Reset Code Sent',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFE8F5E9),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF0B6259),
                                      size: 48,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'We have sent a password reset code to',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _emailController.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  CustomButton(
                                    text: 'Continue',
                                    height: 50,
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      ); // Close dialog
                                      // Navigate to reset password page
                                      _navigateToResetPasswordPage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    // Email not found
                    setState(() {
                      _isLoading = false;
                      _emailError = 'Email not found. Please check your email address.';
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
