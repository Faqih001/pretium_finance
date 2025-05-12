import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/storage_service.dart';
import '../models/transaction.dart';
import 'dart:math';

class PaybillPage extends StatefulWidget {
  const PaybillPage({super.key});

  @override
  State<PaybillPage> createState() => _PaybillPageState();
}

class _PaybillPageState extends State<PaybillPage> {
  final TextEditingController _businessController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  String? _businessError;
  String? _accountError;
  String? _amountError;

  @override
  void dispose() {
    _businessController.dispose();
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _businessError = null;
      _accountError = null;
      _amountError = null;
    });

    bool isValid = true;

    // Validate business number
    if (_businessController.text.isEmpty) {
      setState(() {
        _businessError = 'Please enter business number';
      });
      isValid = false;
    } else if (!RegExp(r'^\d{5,7}$').hasMatch(_businessController.text)) {
      setState(() {
        _businessError = 'Please enter a valid business number';
      });
      isValid = false;
    }

    // Validate account number
    if (_accountController.text.isEmpty) {
      setState(() {
        _accountError = 'Please enter account number';
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
    
    try {
      // Parse amount
      double amount = double.parse(_amountController.text);
      
      // Generate a random ID for the transaction
      String transactionId = 'paybill_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
      
      // Create transaction object
      Transaction transaction = Transaction(
        id: transactionId,
        type: 'paybill',
        recipient: '${_businessController.text} - ${_accountController.text}',
        amount: amount,
        timestamp: DateTime.now(),
        status: 'completed',
        description: 'Account: ${_accountController.text}',
      );
      
      // Save transaction
      await StorageService.saveTransaction(transaction);
      
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
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error processing payment: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paybill',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ), // Using dashboard index since this is accessed from dashboard
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Business number field
                TextFormField(
                  controller: _businessController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Business Number',
                    hintText: 'Enter paybill number',
                    prefixIcon: const Icon(
                      Icons.business,
                      color: Color(0xFF0B6259),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _businessError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _businessError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _businessError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Color(0xFF0B6259),
                                width: 1.0,
                              ),
                    ),
                  ),
                ),
                if (_businessError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Text(
                      _businessError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 20),

                // Account number field
                TextFormField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    hintText: 'Enter account number',
                    prefixIcon: const Icon(
                      Icons.account_box,
                      color: Color(0xFF0B6259),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _accountError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _accountError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _accountError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Color(0xFF0B6259),
                                width: 1.0,
                              ),
                    ),
                  ),
                ),
                if (_accountError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Text(
                      _accountError!,
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
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          _amountError != null
                              ? const BorderSide(color: Colors.red, width: 1.0)
                              : const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
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

                // Popular paybills suggestion
                const Text(
                  'Popular paybills',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                // Row of sample paybills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildPaybillItem('KPLC', '888880'),
                      _buildPaybillItem('DSTV', '444444'),
                      _buildPaybillItem('NHIF', '200222'),
                      _buildPaybillItem('Nairobi Water', '100000'),
                    ],
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

                const SizedBox(height: 30),

                // Pay button
                CustomButton(
                  text: 'Pay Bill',
                  isLoading: _isLoading,
                  onPressed: _validateAndProcess,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaybillItem(String name, String number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _businessController.text = number;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              number,
              style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
            ),
          ],
        ),
      ),
    );
  }
}
