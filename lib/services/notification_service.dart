import 'package:flutter/material.dart';

class NotificationService {
  static OverlayEntry? _currentNotification;

  // Show a notification overlay at the top of the screen
  static void showNotification(
    BuildContext context, {
    required String message,
    Color backgroundColor = const Color(0xFF0B6259),
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Hide any existing notifications
    hideNotification();
    
    // Calculate notification positioning
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top + 10;
    final width = mediaQuery.size.width * 0.9;
    
    // Create a new overlay entry
    _currentNotification = OverlayEntry(
      builder: (context) => Positioned(
        top: topPadding,
        left: (mediaQuery.size.width - width) / 2,
        width: width,
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: textColor),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor, size: 20),
                    onPressed: () => hideNotification(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
    // Insert the notification into the overlay
    Overlay.of(context).insert(_currentNotification!);
    
    // Automatically dismiss after duration
    Future.delayed(duration, () {
      hideNotification();
    });
  }
  
  // Hide the current notification if it exists
  static void hideNotification() {
    _currentNotification?.remove();
    _currentNotification = null;
  }
}
