import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  String? _emailError;

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
                    borderSide: _emailError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: _emailError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: _emailError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : const BorderSide(color: Color(0xFF0B6259), width: 1.0),
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
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 40),

              // Send Reset Code Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
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
                    final bool emailValid = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text);
                    if (!emailValid) {
                      setState(() {
                        _emailError = 'Please enter a valid email';
                      });
                      return;
                    }

                    // Check if email exists in our stored users
                    final userData = await StorageService.getUserData();
                    if (userData != null &&
                        userData['email'] == _emailController.text) {
                      // Save password reset request
                      await StorageService.savePasswordResetRequest(
                        _emailController.text,
                      );

                      // Get reset code to display in snackbar (in real app, this would be sent via email)
                      final resetData =
                          await StorageService.getPasswordResetRequest();
                      final resetCode = resetData?['code'] ?? '000000';

                      if (mounted) {
                        // Show success message with the reset code
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Reset code sent: $resetCode (for demo only)',
                            ),
                            backgroundColor: const Color(0xFF0B6259),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                    } else {
                      // Email not found
                      if (mounted) {
                        setState(() {
                          _emailError = 'Email not found. Please check your email address.';
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B6259),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send Reset Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
