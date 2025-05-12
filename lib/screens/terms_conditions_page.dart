import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B6259),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: May 12, 2025',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('1. Introduction'),
            _buildParagraph(
              'Welcome to Pretium Finance ("Company", "we", "our", "us")! As you have just clicked our Terms of Service, please read these Terms of Service carefully before using our web services or applications.',
            ),
            _buildParagraph(
              'These Terms of Service set forth the legally binding terms and conditions for your use of the Pretium Finance application.',
            ),

            _buildSectionTitle('2. Acceptance of Terms'),
            _buildParagraph(
              'By accessing or using our Service, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, you must not access or use the Service.',
            ),
            _buildParagraph(
              'We reserve the right to change or update these Terms at any time. We will notify you of any changes by posting the new Terms on this page. Changes to the Terms are effective when they are posted.',
            ),

            _buildSectionTitle('3. User Accounts'),
            _buildParagraph(
              'When you create an account with us, you must provide accurate, complete, and current information at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account.',
            ),
            _buildParagraph(
              'You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your account. You agree not to disclose your password to any third party.',
            ),

            _buildSectionTitle('4. Transactions and Payment'),
            _buildParagraph(
              'Pretium Finance provides services for digital wallet management, money transfers, and other financial services. All transactions are subject to verification and applicable laws.',
            ),
            _buildParagraph(
              'We may charge fees for certain services, and these fees will be clearly disclosed to you before you complete any transaction. You agree to pay all charges at the prices in effect when incurring the charges.',
            ),

            _buildSectionTitle('5. Intellectual Property'),
            _buildParagraph(
              'The Service and its original content, features, and functionality are and will remain the exclusive property of Pretium Finance and its licensors. The Service is protected by copyright, trademark, and other laws.',
            ),
            _buildParagraph(
              'Our trademarks and trade dress may not be used in connection with any product or service without the prior written consent of Pretium Finance.',
            ),

            _buildSectionTitle('6. Limitation of Liability'),
            _buildParagraph(
              'In no event shall Pretium Finance, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your access to or use of or inability to access or use the Service.',
            ),

            _buildSectionTitle('7. Governing Law'),
            _buildParagraph(
              'These Terms shall be governed and construed in accordance with the laws of Kenya, without regard to its conflict of law provisions.',
            ),
            _buildParagraph(
              'Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect.',
            ),

            _buildSectionTitle('8. Changes to Terms'),
            _buildParagraph(
              'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. What constitutes a material change will be determined at our sole discretion.',
            ),
            _buildParagraph(
              'By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Service.',
            ),

            _buildSectionTitle('9. Contact Us'),
            _buildParagraph(
              'If you have any questions about these Terms, please contact us at legal@pretium.com',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}
