import 'package:flutter/material.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample asset data
    final assets = [
      {
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'amount': '0.00',
        'value': '0.00',
        'icon': Icons.currency_bitcoin,
        'color': Colors.amber,
      },
      {
        'name': 'Ethereum',
        'symbol': 'ETH',
        'amount': '0.00',
        'value': '0.00',
        'icon': Icons.currency_exchange,
        'color': Colors.blueGrey,
      },
      {
        'name': 'US Dollar',
        'symbol': 'USD',
        'amount': '0.00',
        'value': '0.00',
        'icon': Icons.attach_money,
        'color': Colors.green,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: assets.isEmpty
          ? const Center(
              child: Text(
                'No assets available yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final asset = assets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: asset['color'] as Color,
                      child: Icon(
                        asset['icon'] as IconData,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      asset['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(asset['symbol'] as String),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${asset['amount']} ${asset['symbol']}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'KES ${asset['value']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to asset details
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Asset details not implemented yet'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B6259),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Add new asset
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add asset functionality not implemented yet'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
