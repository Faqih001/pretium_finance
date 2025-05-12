import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'login_page_new.dart';
import 'currency_page.dart';
import 'assets_page.dart';
import 'wallet_address_page.dart';
import 'contact_support_page.dart';
import 'terms_conditions_page.dart';
import 'privacy_policy_page.dart';
import 'delete_account_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _initials = 'FM'; // Default initials
  String _currency = 'KES'; // Default currency
  int _userRating = 0; // For app rating

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageService.getUserData();
    if (userData != null) {
      setState(() {
        _firstName = userData['firstName'] ?? '';
        _lastName = userData['lastName'] ?? '';
        _email = userData['email'] ?? '';
        
        // Generate initials from first and last name
        if (_firstName.isNotEmpty && _lastName.isNotEmpty) {
          _initials = '${_firstName[0]}${_lastName[0]}';
        } else if (_firstName.isNotEmpty) {
          _initials = _firstName[0];
        }
      });
    }
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to sign out?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _signOut();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF0B6259),
                        ),
                        child: const Text('Sign out'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _signOut() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    
    try {
      // Clear all stored data
      await StorageService.clearAll();
      
      // Navigate to login page and remove all previous routes
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
    }
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Rate Pretium Finance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'How would you rate your experience with our app?',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Star rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _userRating 
                                ? Icons.star 
                                : Icons.star_border,
                            color: index < _userRating
                                ? Colors.amber
                                : Colors.grey,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              _userRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    // Submit button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B6259),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _userRating > 0
                          ? () {
                              // Submit rating
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Thank you for rating us $_userRating ${_userRating == 1 ? "star" : "stars"}!'),
                                ),
                              );
                            }
                          : null,
                      child: const Text('SUBMIT'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Not now'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            _buildProfileHeader(),
            
            // Profile options
            _buildProfileOption(
              icon: Icons.currency_exchange,
              title: 'Currency',
              trailing: Text(_currency, style: const TextStyle(color: Color(0xFF0B6259))),
              onTap: () {
                // Navigate to currency settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrencyPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Assets',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to assets page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AssetsPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.swap_horiz,
              title: 'Wallet Address',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to wallet address page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletAddressPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.telegram,
              title: 'Contact Support',
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Open contact support
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactSupportPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.description_outlined,
              title: 'Terms and Conditions',
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Open terms and conditions
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TermsConditionsPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                // Open privacy policy
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.phone_android_outlined,
              title: 'App Version',
              trailing: const Text('1.0.0+16'),
              onTap: null, // Disabled option
            ),
            
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Sign out',
              trailing: const Icon(Icons.chevron_right),
              onTap: _showSignOutDialog,
              textColor: Colors.black87,
            ),
            
            _buildProfileOption(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to delete account page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeleteAccountPage()),
                );
              },
              textColor: Colors.black87,
            ),
            
            const SizedBox(height: 20),
            
            // Rate app button
            GestureDetector(
              onTap: () {
                _showRatingDialog();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Rate App'),
                    const SizedBox(width: 5),
                    Icon(Icons.thumb_up, color: Colors.amber.shade700, size: 18),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Profile circle with initials
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _initials,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Coming soon text and edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.edit, color: Colors.grey.shade700, size: 18),
            ],
          ),
          
          // Email
          Text(
            _email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Widget trailing,
    required Function()? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal.shade800),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
