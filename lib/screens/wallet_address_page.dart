import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletAddressPage extends StatelessWidget {
  const WalletAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample wallet addresses
    final walletAddresses = [
      {
        'name': 'Bitcoin Wallet',
        'address': '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
        'icon': Icons.currency_bitcoin,
      },
      {
        'name': 'Ethereum Wallet',
        'address': '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
        'icon': Icons.currency_exchange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Addresses'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body:
          walletAddresses.isEmpty
              ? const Center(
                child: Text(
                  'No wallet addresses available yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: walletAddresses.length,
                itemBuilder: (context, index) {
                  final wallet = walletAddresses[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                wallet['icon'] as IconData,
                                color: const Color(0xFF0B6259),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                wallet['name'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Address:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            wallet['address'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Copy button
                              TextButton.icon(
                                icon: const Icon(Icons.copy, size: 16),
                                label: const Text('Copy'),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: wallet['address'] as String,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Address copied to clipboard',
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              // Share button
                              TextButton.icon(
                                icon: const Icon(Icons.share, size: 16),
                                label: const Text('Share'),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Share functionality not implemented yet',
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B6259),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Add new wallet address
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Add wallet address functionality not implemented yet',
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
