import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/auth/view/pages/signin-page.dart';
import 'package:nightAngle/features/auth/view/pages/signup-page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Define a default route
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignInPage()),
      ),

      GoRoute(
        name: Routes.login,
        path: '/login',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignInPage()),
      ),

      GoRoute(
          name: Routes.register,
          path: '/register',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpPage())),
    ],
  );
}
