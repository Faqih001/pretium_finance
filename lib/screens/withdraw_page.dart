import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;
  String? _amountError;
  String? _addressError;
  String _selectedCrypto = 'BTC';
  final List<String> _cryptoOptions = ['BTC', 'ETH', 'USDT', 'USDC'];

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateAndProcess() {
    // Reset errors
    setState(() {
      _amountError = null;
      _addressError = null;
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
        } else if (amount > 1000) {
          // Example max limit
          setState(() {
            _amountError = 'Amount exceeds your available balance';
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

    // Validate address
    if (_addressController.text.isEmpty) {
      setState(() {
        _addressError = 'Please enter the recipient address';
      });
      isValid = false;
    } else if (_addressController.text.length < 20) {
      setState(() {
        _addressError = 'Please enter a valid address';
      });
      isValid = false;
    }

    if (isValid) {
      _processWithdrawal();
    }
  }

  Future<void> _processWithdrawal() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate withdrawal processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Withdrawal initiated! Check your transactions for updates.',
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
          'Withdraw',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1), // Using index 1 since this is accessed via the middle QR button
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transfer crypto from your Pretium wallet',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),

              const SizedBox(height: 30),

              // Crypto selection
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: _selectedCrypto,
                  isExpanded: true,
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items:
                      _cryptoOptions.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCrypto = newValue!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Amount field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  labelText: 'Amount',
                  prefixIcon: const Icon(
                    Icons.currency_bitcoin,
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

              // Address field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Recipient Address',
                  labelText: 'Recipient Address',
                  prefixIcon: const Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFF0B6259),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: Color(0xFF0B6259),
                    ),
                    onPressed: () {
                      // Implement QR code scanning
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'QR code scanning not available in demo',
                          ),
                          backgroundColor: Color(0xFF0B6259),
                        ),
                      );
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _addressError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _addressError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        _addressError != null
                            ? const BorderSide(color: Colors.red, width: 1.0)
                            : const BorderSide(
                              color: Color(0xFF0B6259),
                              width: 1.0,
                            ),
                  ),
                ),
              ),
              if (_addressError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _addressError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Fee info
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Transaction Fee',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '0.0005 BTC (Network fee)',
                      style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Warning
              const Text(
                'Please double check the address before confirming withdrawal.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Withdraw button
              CustomButton(
                text: 'Withdraw',
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
