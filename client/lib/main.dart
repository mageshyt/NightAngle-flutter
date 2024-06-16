import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nightAngle/router.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(const ProviderScope(child: MyApp()));
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
