import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../widgets/custom_button.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Error messages
  String? _resetCodeError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _resetCodeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                'Reset Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 12),

              // Instruction text
              const Text(
                'Enter the code sent to your email and set a new password',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),

              const SizedBox(height: 30),

              // Reset Code Input
              TextFormField(
                controller: _resetCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Reset Code',
                  prefixIcon: const Icon(
                    Icons.lock_reset,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _resetCodeError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _resetCodeError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _resetCodeError != null
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
              if (_resetCodeError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _resetCodeError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // New Password Input
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0B6259),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _newPasswordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _newPasswordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _newPasswordError != null
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
              if (_newPasswordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _newPasswordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // Confirm Password Input
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF0B6259),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _confirmPasswordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _confirmPasswordError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _confirmPasswordError != null
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
              if (_confirmPasswordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _confirmPasswordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 30),

              // Reset Password Button
              CustomButton(
                text: 'Reset Password',
                isLoading: _isLoading,
                onPressed: _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle password reset
  Future<void> _resetPassword() async {
    // Reset errors
    setState(() {
      _resetCodeError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    // Validate inputs
    bool isValid = true;

    // Validate reset code
    if (_resetCodeController.text.isEmpty) {
      setState(() {
        _resetCodeError = 'Please enter the reset code';
        isValid = false;
      });
    }

    // Validate new password
    if (_newPasswordController.text.isEmpty) {
      setState(() {
        _newPasswordError = 'Please enter a new password';
        isValid = false;
      });
    } else if (_newPasswordController.text.length < 6) {
      setState(() {
        _newPasswordError = 'Password must be at least 6 characters';
        isValid = false;
      });
    }

    // Validate confirm password
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Please confirm your password';
        isValid = false;
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
        isValid = false;
      });
    }

    // If validation failed, return early
    if (!isValid) {
      return;
    }

    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    // Verify reset code
    final codeValid = await StorageService.verifyResetCode(
      widget.email,
      _resetCodeController.text,
    );

    if (!codeValid) {
      setState(() {
        _isLoading = false;
        _resetCodeError = 'Invalid reset code. Please try again.';
      });
      return;
    }

    // Update password
    final success = await StorageService.updatePassword(
      widget.email,
      _newPasswordController.text,
    );

    // Turn off loading state
    setState(() {
      _isLoading = false;
    });

    if (success && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset successful! Please login with your new password.',
          ),
          backgroundColor: Color(0xFF0B6259),
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate back to login page after short delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          // Navigate to login page, removing all previous routes
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(fromPasswordReset: true),
            ),
            (route) => false,
          );
        }
      });
    } else if (mounted) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to reset password. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
