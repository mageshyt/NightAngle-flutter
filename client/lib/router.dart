import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/auth/view/pages/signin-page.dart';
import 'package:nightAngle/features/auth/view/pages/signup-page.dart';
import 'package:nightAngle/features/home/view/pages/home-page.dart';
import 'package:nightAngle/features/home/view/pages/upload-song-page.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: '/register',
      routes: [
        // Define a default route p
        GoRoute(
          name: Routes.home,
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePage()),
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
          pageBuilder: (context, state) => const MaterialPage(
            child: SignUpPage(),
          ),
        ),

        GoRoute(
          name: Routes.upload,
          path: '/upload',
          pageBuilder: (context, state) => const MaterialPage(
            child: UploadSongPage(),
          ),
        )
      ],
      redirect: (context, state) {
        if (isAuth) {
          return '/';
        }
        return '/login';
      },
    );

    return router;
  }
}
