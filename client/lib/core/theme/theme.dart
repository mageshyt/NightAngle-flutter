import 'package:client/core/core.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
        borderSide: const BorderSide(color: Pallete.borderColor, width: 3),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
        borderSide: const BorderSide(color: Pallete.borderColor, width: 3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
        borderSide: const BorderSide(color: Pallete.primary, width: 3),
      ),
      labelStyle: const TextStyle(color: Pallete.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.cardColor,
      selectedItemColor: Pallete.greenColor,
      unselectedItemColor: Pallete.inactiveBottomBarItemColor,
    ),
  );
}
