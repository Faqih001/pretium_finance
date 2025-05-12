import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/storage_service.dart';
import 'login_page.dart';

class VerifyAccountPage extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  
  const VerifyAccountPage({
    super.key, 
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  final TextEditingController _verificationCodeController = TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();
  String? _codeError;
  bool _keyboardVisible = false;
  bool _notificationVisible = false;
  String _notificationText = '';
  String _selectedCountry = 'Kenya';
  final List<String> _countries = [
    'Kenya', 
    'Uganda', 
    'Nigeria', 
    'Ghana', 
    'Malawi', 
    'Zambia',
    'Rwanda', 
    'Global Users [全球用户]'
  ];
  
  @override
  void initState() {
    super.initState();
    // Monitor keyboard visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        _keyboardVisible = keyboardHeight > 0;
      });
    });
  }
  
  @override
  void dispose() {
    _verificationCodeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }
  
  void _showNotification(String message) {
    setState(() {
      _notificationVisible = true;
      _notificationText = message;
    });
    
    // Hide notification after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _notificationVisible = false;
        });
      }
    });
  }

  void _showCountrySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15))
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Country',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_countries[index]),
                      onTap: () {
                        setState(() {
                          _selectedCountry = _countries[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _resendCode() {
    _showNotification('Verification code resent');
  }
  
  void _verifyEmail() {
    // Validate verification code
    if (_verificationCodeController.text.isEmpty) {
      setState(() {
        _codeError = 'Please enter verification code';
      });
      return;
    }
    
    // In real app, verify code with server here
    // For demo, just accept any 4 digit code
    if (_verificationCodeController.text.length != 4) {
      setState(() {
        _codeError = 'Verification code must be 4 digits';
      });
      return;
    }
    
    // Save user data since email is now verified
    StorageService.saveUserData(
      firstName: widget.firstName,
      lastName: widget.lastName,
      email: widget.email,
      password: widget.password,
    );
    
    // Show success notification
    _showNotification('Email verified successfully! Please login to continue');
    
    // Navigate to login page after short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Check if keyboard is visible
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Verify Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Subtitle
                  const Text(
                    'Enter the verification code sent to your email',
                    style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Country Selection Dropdown
                  GestureDetector(
                    onTap: _showCountrySelector,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1.0
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedCountry,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Verification Code Input
                  TextFormField(
                    controller: _verificationCodeController,
                    focusNode: _codeFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onTap: () {
                      setState(() {
                        _keyboardVisible = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter 4-digit code',
                      counterText: '',
                      prefixText: '1234 ',
                      prefixStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: const Icon(
                        Icons.security,
                        color: Color(0xFF0B6259),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: _codeError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: _codeError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: _codeError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Color(0xFF0B6259), width: 1.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  if (_codeError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                      child: Text(
                        _codeError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    
                  const SizedBox(height: 40),
                  
                  // Verify Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _verifyEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B6259),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Verify Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Didn't receive code text and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn\'t receive the code?',
                        style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                      ),
                      TextButton(
                        onPressed: _resendCode,
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0B6259),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Space at bottom to avoid keyboard overlap
                  SizedBox(height: _keyboardVisible ? 200 : 20),
                ],
              ),
            ),
            
            // Notification at bottom
            if (_notificationVisible)
              Positioned(
                bottom: _keyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 70,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B6259),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _notificationText,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
