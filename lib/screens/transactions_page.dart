import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/storage_service.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
    });

    final transactions = await StorageService.getTransactions();

    if (mounted) {
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    }
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'send':
        return Icons.send;
      case 'buy_goods':
        return Icons.shopping_cart_outlined;
      case 'paybill':
        return Icons.receipt_long_outlined;
      case 'airtime':
        return Icons.phone_android_outlined;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getTransactionColor(String status) {
    switch (status) {
      case 'completed':
        return const Color(0xFF0B6259);
      case 'failed':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getTransactionTitle(Transaction transaction) {
    switch (transaction.type) {
      case 'send':
        return 'Sent to ${transaction.recipient}';
      case 'buy_goods':
        return 'Purchased from ${transaction.recipient}';
      case 'paybill':
        return 'Paid bill to ${transaction.recipient}';
      case 'airtime':
        return 'Airtime for ${transaction.recipient}';
      default:
        return transaction.recipient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTransactions,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _transactions.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No transactions yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              : RefreshIndicator(
                onRefresh: _loadTransactions,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getTransactionColor(
                              transaction.status,
                            ).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getTransactionIcon(transaction.type),
                            color: _getTransactionColor(transaction.status),
                          ),
                        ),
                        title: Text(
                          _getTransactionTitle(transaction),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          DateFormat(
                            'MMM d, y • h:mm a',
                          ).format(transaction.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'KES ${transaction.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getTransactionColor(transaction.status),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: _getTransactionColor(transaction.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
