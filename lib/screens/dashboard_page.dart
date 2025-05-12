import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/transaction.dart';
import 'transactions_page.dart';
import 'send_money_page.dart';
import 'buy_goods_page.dart';
import 'paybill_page.dart';
import 'airtime_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _firstName = '';
  String _lastName = '';
  String _initials = 'U';
  bool _isBalanceVisible = false;
  double _walletBalance = 0.0;
  List<Transaction> _recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadWalletBalance();
    _loadRecentTransactions();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageService.getUserData();
    if (userData != null && mounted) {
      setState(() {
        _firstName = userData['firstName'] ?? '';
        _lastName = userData['lastName'] ?? '';

        // Create initials from first and last name
        if (_firstName.isNotEmpty && _lastName.isNotEmpty) {
          _initials = '${_firstName[0]}${_lastName[0]}'.toUpperCase();
        } else if (_firstName.isNotEmpty) {
          _initials = _firstName[0].toUpperCase();
        } else {
          _initials = 'U';
        }
      });
    }
  }

  Future<void> _loadWalletBalance() async {
    final balance = await StorageService.getWalletBalance();
    if (mounted) {
      setState(() {
        _walletBalance = balance;
      });
    }
  }

  Future<void> _loadRecentTransactions() async {
    final transactions = await StorageService.getRecentTransactions(3);
    if (mounted) {
      setState(() {
        _recentTransactions = transactions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Column(
          children: [
            // Top app bar with greeting and notification
            _buildAppBar(),

            // Wallet balance card
            _buildWalletCard(),

            // Financial services section
            _buildFinancialServices(),

            // Recent transactions section
            _buildRecentTransactions(),

            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // User avatar
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _initials,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Greeting
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${_firstName.isNotEmpty ? _firstName : 'User'} 👋',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Notification bell
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 28),
            onPressed: () {
              // Show a sample notification
              NotificationService.showNotification(
                context,
                message: 'Welcome to Pretium Finance! Your financial partner.',
                icon: Icons.info_outline,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6259), Color(0xFF0B6666)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B6259).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Currency icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.currency_exchange,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              // Eye icon to toggle balance visibility
              IconButton(
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Wallet balance text
          const Text(
            'Wallet Balance',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 8),

          // Balance amount
          Text(
            _isBalanceVisible
                ? 'KES ${_walletBalance.toStringAsFixed(2)}'
                : 'KES ****',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // Dollar equivalent amount using today's rate (May 12, 2025)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              _isBalanceVisible
                  ? '\$ ${(_walletBalance / 130.45).toStringAsFixed(2)}'
                  : '\$ ****',
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialServices() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Financial Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              // Country dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Kenya',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0B6259),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Service icons grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceItem(
                icon: Icons.send,
                label: 'Send Money',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SendMoneyPage(),
                    ),
                  ).then((_) {
                    _loadWalletBalance();
                    _loadRecentTransactions();
                  });
                },
              ),
              _buildServiceItem(
                icon: Icons.shopping_cart_outlined,
                label: 'Buy Goods',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuyGoodsPage(),
                    ),
                  ).then((_) {
                    _loadWalletBalance();
                    _loadRecentTransactions();
                  });
                },
              ),
              _buildServiceItem(
                icon: Icons.receipt_long_outlined,
                label: 'Paybill',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaybillPage(),
                    ),
                  ).then((_) {
                    _loadWalletBalance();
                    _loadRecentTransactions();
                  });
                },
              ),
              _buildServiceItem(
                icon: Icons.phone_android_outlined,
                label: 'Airtime',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AirtimePage(),
                    ),
                  ).then((_) {
                    _loadWalletBalance();
                    _loadRecentTransactions();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF0B6259), size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionsPage(),
                    ),
                  ).then((_) => _loadRecentTransactions());
                },
                child: const Text(
                  'See all',
                  style: TextStyle(fontSize: 14, color: Color(0xFF0B6259)),
                ),
              ),
            ],
          ),

          // Empty state or transaction list
          const SizedBox(height: 16),
          _recentTransactions.isEmpty
              ? const Center(
                child: Text(
                  'No transactions yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : Column(
                children:
                    _recentTransactions.map((transaction) {
                      IconData transactionIcon;
                      String transactionTitle;

                      switch (transaction.type) {
                        case 'send':
                          transactionIcon = Icons.send;
                          transactionTitle = 'Sent to ${transaction.recipient}';
                          break;
                        case 'buy_goods':
                          transactionIcon = Icons.shopping_cart_outlined;
                          transactionTitle =
                              'Purchased from ${transaction.recipient}';
                          break;
                        case 'paybill':
                          transactionIcon = Icons.receipt_long_outlined;
                          transactionTitle =
                              'Paid bill to ${transaction.recipient}';
                          break;
                        case 'airtime':
                          transactionIcon = Icons.phone_android_outlined;
                          transactionTitle =
                              'Airtime for ${transaction.recipient}';
                          break;
                        default:
                          transactionIcon = Icons.swap_horiz;
                          transactionTitle = transaction.recipient;
                      }

                      Color statusColor;
                      switch (transaction.status) {
                        case 'completed':
                          statusColor = const Color(0xFF0B6259);
                          break;
                        case 'failed':
                          statusColor = Colors.red;
                          break;
                        case 'pending':
                          statusColor = Colors.orange;
                          break;
                        default:
                          statusColor = Colors.grey;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                transactionIcon,
                                color: statusColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transactionTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat(
                                      'MMM d, y • h:mm a',
                                    ).format(transaction.timestamp),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'KES ${transaction.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    transaction.status.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
        ],
      ),
    );
  }
}
