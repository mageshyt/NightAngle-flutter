import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nightAngle/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Night Angle',
      theme: AppTheme.darkThemeMode,
      routerConfig: AppRouter().router,
    );
  }
}
