import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'confirm_pin_page.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final TextEditingController _pinController = TextEditingController();
  final List<bool> _pinFilled = [false, false, false, false];

  void _onPinChanged(String value) {
    setState(() {
      // Reset all to unfilled
      for (int i = 0; i < 4; i++) {
        _pinFilled[i] = false;
      }

      // Fill based on current length
      for (int i = 0; i < value.length; i++) {
        if (i < 4) {
          _pinFilled[i] = true;
        }
      }
    });

    // If all 4 digits are entered, navigate to confirm page
    if (value.length == 4) {
      // Wait a moment to show the filled state before navigating
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmPinPage(pin: value)),
        );
      });
    }
  }

  void _onKeyPressed(String digit) {
    if (digit == 'backspace') {
      if (_pinController.text.isNotEmpty) {
        _pinController.text = _pinController.text.substring(
          0,
          _pinController.text.length - 1,
        );
      }
    } else if (_pinController.text.length < 4) {
      _pinController.text = _pinController.text + digit;
    }

    _onPinChanged(_pinController.text);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B6259),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Lock Icon
            const Icon(Icons.lock_outline, size: 60, color: Colors.white),
            const SizedBox(height: 20),
            // Title
            const Text(
              'Create a 4-digit PIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            // PIN Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color:
                        _pinFilled[index] ? Colors.white : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Description text
            const Text(
              'Your PIN will be required to access the app',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Spacer(),
            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: [
                  _buildKeypadButton('1'),
                  _buildKeypadButton('2'),
                  _buildKeypadButton('3'),
                  _buildKeypadButton('4'),
                  _buildKeypadButton('5'),
                  _buildKeypadButton('6'),
                  _buildKeypadButton('7'),
                  _buildKeypadButton('8'),
                  _buildKeypadButton('9'),
                  const SizedBox(), // Empty space
                  _buildKeypadButton('0'),
                  _buildKeypadButton('backspace', isIcon: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String digit, {bool isIcon = false}) {
    return TextButton(
      onPressed: () => _onKeyPressed(digit),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
      child:
          isIcon
              ? const Icon(
                Icons.backspace_outlined,
                color: Colors.white,
                size: 28,
              )
              : Text(
                digit,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
    );
  }
}
