import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'signup_page.dart';
import 'dashboard_page.dart';
import '../services/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final email = await StorageService.getEmail();
    if (email != null) {
      setState(() {
        _emailController.text = email;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // App Logo
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4F4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                  color: Color(0xFF0B6259),
                ),
              ),

              const SizedBox(height: 24),

              // Welcome Back Text
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue',
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
                    borderSide: _passwordError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: _passwordError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: _passwordError != null 
                        ? const BorderSide(color: Colors.red, width: 1.0) 
                        : const BorderSide(color: Color(0xFF0B6259), width: 1.0),
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
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Remember Me and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) async {
                          setState(() {
                            _rememberMe = value ?? false;
                          });

                          // If remember me is checked, save the email
                          if (_rememberMe && _emailController.text.isNotEmpty) {
                            await StorageService.saveEmail(
                              _emailController.text,
                            );
                          } else if (!_rememberMe) {
                            // If unchecked, clear saved email
                            await StorageService.saveEmail('');
                          }
                        },
                        activeColor: const Color(0xFF0B6259),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0B6259),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate inputs
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter both email and password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Get user data from storage
                    final userData = await StorageService.getUserData();

                    // Check if credentials match
                    if (userData != null &&
                        userData['email'] == _emailController.text &&
                        userData['password'] == _passwordController.text) {
                      // Save login status and current email
                      await StorageService.saveLoginStatus(true);
                      await StorageService.saveEmail(_emailController.text);

                      // In a real app, navigate to the home/dashboard screen
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login successful!'),
                            backgroundColor: Color(0xFF0B6259),
                          ),
                        );

                        // Navigate to dashboard screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ),
                        );
                      }
                    } else {
                      // Invalid credentials
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid email or password'),
                            backgroundColor: Colors.red,
                          ),
                        );
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
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
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
