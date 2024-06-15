import 'package:client/core/core.dart';
import 'package:client/features/auth/view/pages/signup-screen.dart';
import 'package:client/features/auth/view/pages/signin-page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Night Angle',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
