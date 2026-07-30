import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryDark = Color(0xFF4C3FD7);
  static const Color background = Color(0xFFF5F6FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF9B9BAB);
  static const Color income = Color(0xFF2ECC71);
  static const Color incomeBg = Color(0xFFE3F9EE);
  static const Color expense = Color(0xFFFF5A67);
  static const Color expenseBg = Color(0xFFFDE8EA);
  static const Color divider = Color(0xFFEEEEF2);

  static const List<Color> categoryColors = [
    Color(0xFF5B6EF5), // blue
    Color(0xFFFF6584), // pink/red
    Color(0xFFFFA26B), // orange
    Color(0xFF2ED9C3), // teal
    Color(0xFF9B6BFF), // purple
  ];
}

class AppTextStyles {
  static const TextStyle heading =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static const TextStyle subtitle =
      TextStyle(fontSize: 13, color: AppColors.textSecondary);
  static const TextStyle amountLarge =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white);
  static const TextStyle body =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
}
