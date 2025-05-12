import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../models/transaction.dart';
import 'dart:math';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  String? _recipientError;
  String? _amountError;

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _recipientError = null;
      _amountError = null;
    });

    bool isValid = true;

    // Validate recipient
    if (_recipientController.text.isEmpty) {
      setState(() {
        _recipientError = 'Please enter recipient email or phone';
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
      _processTransfer();
    }
  }

  Future<void> _processTransfer() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Parse amount
      double amount = double.parse(_amountController.text);
      
      // Generate a random ID for the transaction
      String transactionId = 'send_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
      
      // Create transaction object
      Transaction transaction = Transaction(
        id: transactionId,
        type: 'send',
        recipient: _recipientController.text,
        amount: amount,
        timestamp: DateTime.now(),
        status: 'completed',
      );
      
      // Save transaction
      await StorageService.saveTransaction(transaction);
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Show success message using the notification service
        NotificationService.showNotification(
          context,
          message: 'Money sent successfully!',
          icon: Icons.check_circle_outline,
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Show error message using notification service
        NotificationService.showNotification(
          context,
          message: 'Error processing transfer: $e',
          backgroundColor: Colors.red.shade700,
          icon: Icons.error_outline,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Money',
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient field
              TextFormField(
                controller: _recipientController,
                decoration: InputDecoration(
                  labelText: 'Recipient',
                  hintText: 'Email or phone number',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF0B6259),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _recipientError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _recipientError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _recipientError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                ),
              ),
              if (_recipientError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _recipientError!,
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
                      style: TextStyle(fontSize: 15, color: Color(0xFF757575)),
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

              // Send button
              CustomButton(
                text: 'Send Money',
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
