import 'package:flutter/material.dart';
import '../screens/dashboard_page.dart';
import '../screens/transactions_page.dart';
import '../screens/deposit_page.dart';
import '../screens/fund_account_page.dart';
import '../screens/withdraw_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        color: Colors.white,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0
                  ? Icons.account_balance_wallet
                  : Icons.account_balance_wallet_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0B6259),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.qr_code, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2 ? Icons.receipt : Icons.receipt_outlined,
            ),
            label: '',
          ),
        ],
        currentIndex:
            currentIndex == 1
                ? 0
                : currentIndex, // Adjust since middle button is special
        selectedItemColor: const Color(0xFF0B6259),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // Handle navigation based on tapped index
          if (index == currentIndex) {
            return; // Already on this page
          }

          if (index == 1) {
            // Middle button - show QR modal
            _showQRCodeModal(context);
          } else if (index == 0 && currentIndex != 0) {
            // Navigate to dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          } else if (index == 2 && currentIndex != 2) {
            // Navigate to transactions
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TransactionsPage()),
            );
          }
        },
      ),
    );
  }

  void _showQRCodeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Options
              _buildQROption(
                icon: Icons.call_received,
                backgroundColor: const Color(0xFFE8F5F3),
                iconColor: const Color(0xFF0B6259),
                title: 'Deposit',
                subtitle: 'Send crypto to your Pretium wallet',
                onTap: () {
                  Navigator.pop(context);
                  // Check if we're already on the DepositPage
                  if (context.widget is! DepositPage) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DepositPage(),
                      ),
                    );
                  }
                },
                context: context,
              ),

              const SizedBox(height: 15),

              _buildQROption(
                icon: Icons.add,
                backgroundColor: const Color(0xFFE8F5F3),
                iconColor: const Color(0xFF0B6259),
                title: 'Fund account',
                subtitle: 'Buy crypto with mobile money',
                onTap: () {
                  Navigator.pop(context);
                  // Check if we're already on the FundAccountPage
                  if (context.widget is! FundAccountPage) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FundAccountPage(),
                      ),
                    );
                  }
                },
                context: context,
              ),

              const SizedBox(height: 15),

              _buildQROption(
                icon: Icons.arrow_outward,
                backgroundColor: const Color(0xFFE8F5F3),
                iconColor: const Color(0xFF0B6259),
                title: 'Withdraw',
                subtitle: 'Transfer crypto from your Pretium wallet',
                onTap: () {
                  Navigator.pop(context);
                  // Check if we're already on the WithdrawPage
                  if (context.widget is! WithdrawPage) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithdrawPage(),
                      ),
                    );
                  }
                },
                context: context,
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQROption({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
