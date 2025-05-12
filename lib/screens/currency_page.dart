import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  String _selectedCurrency = 'KES'; // Default currency

  final List<Map<String, dynamic>> _currencies = [
    {'code': 'KES', 'name': 'Kenyan Shilling', 'symbol': 'KSh'},
    {'code': 'USD', 'name': 'US Dollar', 'symbol': '\$'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€'},
    {'code': 'GBP', 'name': 'British Pound', 'symbol': '£'},
    {'code': 'NGN', 'name': 'Nigerian Naira', 'symbol': '₦'},
    {'code': 'ZAR', 'name': 'South African Rand', 'symbol': 'R'},
    {'code': 'UGX', 'name': 'Ugandan Shilling', 'symbol': 'USh'},
    {'code': 'TZS', 'name': 'Tanzanian Shilling', 'symbol': 'TSh'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Settings'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _currencies.length,
        itemBuilder: (context, index) {
          final currency = _currencies[index];
          final bool isSelected = currency['code'] == _selectedCurrency;

          return ListTile(
            title: Text(currency['code']),
            subtitle: Text(currency['name']),
            trailing:
                isSelected
                    ? const Icon(Icons.check_circle, color: Color(0xFF0B6259))
                    : null,
            onTap: () {
              setState(() {
                _selectedCurrency = currency['code'];
              });

              // In a real app, you would save this preference
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Currency changed to ${currency['name']}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
