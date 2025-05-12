import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'login_page_new.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool _isLoading = false;
  bool _confirmDelete = false;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    if (!_confirmDelete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm account deletion by checking the box'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );

    // Simulate API call for account deletion
    await Future.delayed(const Duration(seconds: 3));

    // Clear all stored data
    await StorageService.clearAll();

    // Close loading dialog
    if (mounted) Navigator.of(context).pop();

    setState(() {
      _isLoading = false;
    });

    // Show completion message and navigate to login page
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Account Deleted'),
            content: const Text(
              'Your account has been successfully deleted. We\'re sorry to see you go.',
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Warning title
            const Center(
              child: Text(
                'Delete Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Warning message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                color: Colors.red.withOpacity(0.05),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Warning:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Deleting your account is permanent. Once you delete your account:',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• All your personal information will be deleted\n'
                    '• You will lose access to your transaction history\n'
                    '• Any funds in your wallet must be withdrawn first\n'
                    '• This action cannot be undone',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Reason field
            const Text(
              'Please tell us why you\'re leaving:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reasonController,
              decoration: InputDecoration(
                hintText: 'Your feedback helps us improve',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Confirmation checkbox
            Row(
              children: [
                Checkbox(
                  value: _confirmDelete,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _confirmDelete = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I understand that this action is permanent and cannot be undone',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Delete button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text('DELETE MY ACCOUNT'),
              ),
            ),
            const SizedBox(height: 16),

            // Cancel button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
