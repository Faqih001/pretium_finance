import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';

class AirtimePage extends StatefulWidget {
  const AirtimePage({super.key});

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  String? _phoneError;
  String? _amountError;
  String _selectedProvider = 'Safaricom';
  final List<String> _providers = ['Safaricom', 'Airtel', 'Telkom', 'Faiba'];

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _phoneError = null;
      _amountError = null;
    });

    bool isValid = true;

    // Validate phone
    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneError = 'Please enter a phone number';
      });
      isValid = false;
    } else if (!RegExp(r'^\d{10,12}$').hasMatch(_phoneController.text)) {
      setState(() {
        _phoneError = 'Please enter a valid phone number';
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
      _processPurchase();
    }
  }

  Future<void> _processPurchase() async {
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
          content: Text('Airtime purchase successful!'),
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
          'Buy Airtime',
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
              // Provider selection
              const Text(
                'Select provider',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 12),

              // Provider logos
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      _providers.map((provider) {
                        bool isSelected = provider == _selectedProvider;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedProvider = provider;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? const Color(0xFFE8F5F3)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? const Color(0xFF0B6259)
                                        : const Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: _getProviderColor(provider),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      provider[0],
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  provider,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w500
                                            : FontWeight.normal,
                                    color:
                                        isSelected
                                            ? const Color(0xFF0B6259)
                                            : const Color(0xFF222222),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Phone number field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
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

              // Quick amounts
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    [10, 20, 50, 100, 200, 500, 1000].map((amount) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _amountController.text = amount.toString();
                            _amountError = null;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Text(
                            'KES $amount',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0B6259),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),

              const Spacer(),

              // Buy button
              CustomButton(
                text: 'Buy Airtime',
                isLoading: _isLoading,
                onPressed: _validateAndProcess,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProviderColor(String provider) {
    switch (provider) {
      case 'Safaricom':
        return Colors.green;
      case 'Airtel':
        return Colors.red;
      case 'Telkom':
        return Colors.blue;
      case 'Faiba':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
