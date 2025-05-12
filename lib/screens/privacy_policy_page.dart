import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B6259),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: May 12, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('1. Introduction'),
            _buildParagraph(
              'Pretium Finance ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application or our services.'
            ),
            _buildParagraph(
              'Please read this Privacy Policy carefully. By using the Application, you consent to the data practices described in this statement.'
            ),
            
            _buildSectionTitle('2. Information We Collect'),
            _buildParagraph(
              'We may collect several types of information from and about users of our Application, including:'
            ),
            _buildListItem(
              'Personal information: Name, email address, telephone number, postal address, date of birth, and identification documents for KYC compliance.'
            ),
            _buildListItem(
              'Financial information: Bank account details, payment card details, and transaction history.'
            ),
            _buildListItem(
              'Device information: Device type, operating system, browser type, IP address, and mobile device identifiers.'
            ),
            _buildListItem(
              'Usage data: How you use our Application, including your interactions with features, content, and links.'
            ),
            
            _buildSectionTitle('3. How We Use Your Information'),
            _buildParagraph(
              'We may use the information we collect about you for various purposes, including to:'
            ),
            _buildListItem(
              'Process transactions and provide our services'
            ),
            _buildListItem(
              'Verify your identity and prevent fraud'
            ),
            _buildListItem(
              'Provide customer support and respond to your inquiries'
            ),
            _buildListItem(
              'Send you important information regarding the Application, changes to our terms, conditions, and policies'
            ),
            _buildListItem(
              'Improve and personalize your experience with our Application'
            ),
            _buildListItem(
              'Comply with legal obligations and enforce our rights'
            ),
            
            _buildSectionTitle('4. Disclosure of Your Information'),
            _buildParagraph(
              'We may disclose personal information that we collect or you provide as described in this Privacy Policy:'
            ),
            _buildListItem(
              'To service providers we use to support our business'
            ),
            _buildListItem(
              'To comply with any court order, law, or legal process'
            ),
            _buildListItem(
              'To enforce or apply our terms of use and other agreements'
            ),
            _buildListItem(
              'To protect the rights, property, or safety of our users or others'
            ),
            
            _buildSectionTitle('5. Data Security'),
            _buildParagraph(
              'We have implemented measures designed to secure your personal information from accidental loss and from unauthorized access, use, alteration, and disclosure.'
            ),
            _buildParagraph(
              'The safety and security of your information also depends on you. Where you have chosen a password for access to our Application, you are responsible for keeping this password confidential.'
            ),
            
            _buildSectionTitle('6. Your Choices About Collection and Use of Your Information'),
            _buildParagraph(
              'You can choose not to provide us with certain information, but that may result in you being unable to use certain features of our Application.'
            ),
            _buildParagraph(
              'You can set your browser or mobile device to refuse all or some cookies, or to alert you when cookies are being sent. If you disable or refuse cookies, please note that some parts of this Application may then be inaccessible or not function properly.'
            ),
            
            _buildSectionTitle('7. Changes to Our Privacy Policy'),
            _buildParagraph(
              'We may update our Privacy Policy from time to time. If we make material changes to how we treat our users\' personal information, we will post the new Privacy Policy on this page and notify you through the application.'
            ),
            _buildParagraph(
              'The date the Privacy Policy was last revised is identified at the top of the page. You are responsible for periodically visiting this Privacy Policy to check for any changes.'
            ),
            
            _buildSectionTitle('8. Contact Information'),
            _buildParagraph(
              'To ask questions or comment about this Privacy Policy and our privacy practices, contact us at: privacy@pretium.com'
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
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
  
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
