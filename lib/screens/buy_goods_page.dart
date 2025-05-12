import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';

class BuyGoodsPage extends StatefulWidget {
  const BuyGoodsPage({super.key});

  @override
  State<BuyGoodsPage> createState() => _BuyGoodsPageState();
}

class _BuyGoodsPageState extends State<BuyGoodsPage> {
  final TextEditingController _tillNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  String? _tillNumberError;
  String? _amountError;

  @override
  void dispose() {
    _tillNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _tillNumberError = null;
      _amountError = null;
    });

    bool isValid = true;

    // Validate till number
    if (_tillNumberController.text.isEmpty) {
      setState(() {
        _tillNumberError = 'Please enter till number';
      });
      isValid = false;
    } else if (!RegExp(r'^\d{5,7}$').hasMatch(_tillNumberController.text)) {
      setState(() {
        _tillNumberError = 'Please enter a valid till number';
      });
      isValid = false;
    }

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
        } else if (amount > 1000) {
          // Example balance check
          setState(() {
            _amountError = 'Insufficient balance';
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

    if (isValid) {
      _processPayment();
    }
  }

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show success message and go back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful!'),
          backgroundColor: Color(0xFF0B6259),
        ),
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buy Goods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Using dashboard index since this is accessed from dashboard
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Till number field
              TextFormField(
                controller: _tillNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Till Number',
                  hintText: 'Enter merchant till number',
                  prefixIcon: const Icon(
                    Icons.store,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _tillNumberError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _tillNumberError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _tillNumberError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                                color: Color(0xFF0B6259),
                                width: 1.0,
                              ),
                  ),
                ),
              ),
              if (_tillNumberError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _tillNumberError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Amount field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                  prefixText: 'KES ',
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

              const SizedBox(height: 24),

              // Available balance
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Available balance:',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF757575),
                      ),
                    ),
                    Text(
                      'KES 0.00',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Pay button
              CustomButton(
                text: 'Pay Now',
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
