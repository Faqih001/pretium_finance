import 'package:flutter/material.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your message has been sent. We\'ll get back to you soon.',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form
        _subjectController.clear();
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
        backgroundColor: const Color(0xFF0B6259),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Support channels
            const Text(
              'Support Channels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Email support
            _buildSupportChannelCard(
              icon: Icons.email,
              title: 'Email Support',
              description:
                  'Send us an email and we\'ll respond within 24 hours',
              actionText: 'support@pretium.com',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email functionality not implemented yet'),
                  ),
                );
              },
            ),

            // Live chat
            _buildSupportChannelCard(
              icon: Icons.chat_bubble_outline,
              title: 'Live Chat',
              description: 'Chat with our support team in real-time',
              actionText: 'Start Chat',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Live chat functionality not implemented yet',
                    ),
                  ),
                );
              },
            ),

            // Phone support
            _buildSupportChannelCard(
              icon: Icons.phone,
              title: 'Phone Support',
              description: 'Call our support team during business hours',
              actionText: '+254 700 123 456',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Phone call functionality not implemented yet',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // Contact form
            const Text(
              'Send us a message',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Subject field
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Message field
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B6259),
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
                            : const Text('SEND MESSAGE'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // FAQ section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _buildFaqItem(
              question: 'How do I reset my password?',
              answer:
                  'You can reset your password by clicking on "Forgot Password" on the login screen and following the instructions sent to your email.',
            ),

            _buildFaqItem(
              question: 'How long do transfers take?',
              answer:
                  'Most transfers are processed instantly, but in some cases, it might take up to 24 hours depending on the destination bank.',
            ),

            _buildFaqItem(
              question: 'How do I change my phone number?',
              answer:
                  'To change your phone number, go to your profile settings and update your contact information.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportChannelCard({
    required IconData icon,
    required String title,
    required String description,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B6259).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF0B6259), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      actionText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0B6259),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
        ),
      ],
    );
  }
}
