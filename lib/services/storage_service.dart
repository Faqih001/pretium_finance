import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String emailKey = 'user_email';
  static const String passwordResetRequestKey = 'password_reset_request';
  static const String pinKey = 'user_pin';
  static const String hasPinKey = 'has_pin';

  // Save user data (from signup)
  static Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final userData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'createdAt': DateTime.now().toIso8601String(),
    };

    await prefs.setString(userKey, jsonEncode(userData));
    await prefs.setString(emailKey, email);
  }

  // Save login status
  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  // Save current user email
  static Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
  }

  // Save password reset request
  static Future<void> savePasswordResetRequest(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final resetData = {
      'email': email,
      'requestedAt': DateTime.now().toIso8601String(),
      'code': generateResetCode(),
    };

    await prefs.setString(passwordResetRequestKey, jsonEncode(resetData));
  }

  // Generate a random 6-digit reset code
  static String generateResetCode() {
    // Simple implementation for demo purposes
    return (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString(userKey);

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Get current user email
  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  // Get password reset request
  static Future<Map<String, dynamic>?> getPasswordResetRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? resetData = prefs.getString(passwordResetRequestKey);

    if (resetData != null) {
      return jsonDecode(resetData);
    }
    return null;
  }

  // Clear all stored data (for logout)
  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Update user password
  static Future<bool> updatePassword(String email, String newPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString(userKey);

    if (userData != null) {
      final Map<String, dynamic> user = jsonDecode(userData);

      // Check if the email matches
      if (user['email'] == email) {
        // Update password
        user['password'] = newPassword;
        user['updatedAt'] = DateTime.now().toIso8601String();

        // Save updated user data
        await prefs.setString(userKey, jsonEncode(user));

        // Clear reset request after successful update
        await prefs.remove(passwordResetRequestKey);

        return true;
      }
    }
    return false;
  }

  // Verify reset code
  static Future<bool> verifyResetCode(String email, String code) async {
    final resetData = await getPasswordResetRequest();

    if (resetData != null &&
        resetData['email'] == email &&
        resetData['code'] == code) {
      return true;
    }
    return false;
  }

  // Save user PIN
  static Future<void> savePin(String pin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(pinKey, pin);
    await prefs.setBool(hasPinKey, true);
  }

  // Get user PIN
  static Future<String?> getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(pinKey);
  }

  // Check if user has PIN
  static Future<bool> hasPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasPinKey) ?? false;
  }

  // Get login status
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
}
