import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';

class FundAccountPage extends StatefulWidget {
  const FundAccountPage({super.key});

  @override
  State<FundAccountPage> createState() => _FundAccountPageState();
}

class _FundAccountPageState extends State<FundAccountPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _amountError;
  String? _phoneError;

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _amountError = null;
      _phoneError = null;
    });

    bool isValid = true;

    // Validate amount
    if (_amountController.text.isEmpty) {
      setState(() {
        _amountError = 'Please enter an amount';
      });
      isValid = false;
    } else {
      try {
        double amount = double.parse(_amountController.text);
        if (amount <= 0) {
          setState(() {
            _amountError = 'Amount must be greater than 0';
          });
          isValid = false;
        }
      } catch (e) {
        setState(() {
          _amountError = 'Please enter a valid number';
        });
        isValid = false;
      }
    }

    // Validate phone
    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneError = 'Please enter your phone number';
      });
      isValid = false;
    } else if (!RegExp(r'^\d{10,12}$').hasMatch(_phoneController.text)) {
      setState(() {
        _phoneError = 'Please enter a valid phone number';
      });
      isValid = false;
    }

    if (isValid) {
      _processPayment();
    }
  }

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Payment initiated! Check your phone for confirmation.',
          ),
          backgroundColor: Color(0xFF0B6259),
        ),
      );

      // Pop back to previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Fund Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buy crypto with mobile money',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),

              const SizedBox(height: 30),

              // Amount field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount (KES)',
                  labelText: 'Amount',
                  prefixIcon: const Icon(
                    Icons.attach_money,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _amountError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _amountError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _amountError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                ),
              ),
              if (_amountError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _amountError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Phone number field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF0B6259)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _phoneError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _phoneError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _phoneError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                ),
              ),
              if (_phoneError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _phoneError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 30),

              // Information box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5F3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    Text(
                      'How it works',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B6259),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Enter the amount you want to deposit',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '2. Enter your phone number for mobile money payment',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '3. You will receive a prompt on your phone',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '4. Once payment is confirmed, your wallet will be credited',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue button
              CustomButton(
                text: 'Continue',
                isLoading: _isLoading,
                onPressed: _validateAndProcess,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
