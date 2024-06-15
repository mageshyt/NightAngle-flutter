import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Pallete.cardColor,
        selectedItemColor: Pallete.greenColor,
        unselectedItemColor: Pallete.inactiveBottomBarItemColor,
      ));
}
