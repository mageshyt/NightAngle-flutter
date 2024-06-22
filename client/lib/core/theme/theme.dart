import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:nightAngle/core/theme/border-style.dart';
import 'package:nightAngle/core/theme/text-style.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Pallete.white),
    ),
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: BorderStyles.outlineInputBorder,
      enabledBorder: BorderStyles.outlineInputBorderEnabled,
      focusedBorder: BorderStyles.outlineInputBorderFocused,
      errorBorder: BorderStyles.outlineErrorBorder,
      hintStyle: TextStyles.labelStyle,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.cardColor,
      selectedItemColor: Pallete.greenColor,
      unselectedItemColor: Pallete.inactiveBottomBarItemColor,
    ),
  );
}
