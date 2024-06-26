import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/auth/view/pages/signin-page.dart';
import 'package:nightAngle/features/auth/view/pages/signup-page.dart';
import 'package:nightAngle/features/home/view/pages/home-page.dart';
import 'package:nightAngle/features/home/view/pages/upload-song-page.dart';
import 'package:nightAngle/features/home/view/pages/music%20player.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: Routes.musicPlay,
      routes: [
        // Define a default route p
        GoRoute(
          name: RoutesName.home,
          path: Routes.home,
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePage()),
        ),

        GoRoute(
          name: RoutesName.login,
          path: Routes.login,
          pageBuilder: (context, state) => const MaterialPage(
            child: SignInPage(),
          ),
        ),

        GoRoute(
          name: RoutesName.register,
          path: Routes.register,
          pageBuilder: (context, state) => const MaterialPage(
            child: SignUpPage(),
          ),
        ),

        GoRoute(
          name: RoutesName.upload,
          path: Routes.upload,
          pageBuilder: (context, state) => const MaterialPage(
            child: UploadSongPage(),
          ),
        ),

        GoRoute(
          name: RoutesName.musicPlay,
          path: Routes.musicPlay,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: MusicPlayer(),
            );
          },
        ),
      ],
      // redirect: (context, state) {
      //   if (isAuth) {
      //     return '/';
      //   }
      //   return '/login';
      // },
    );

    return router;
  }
}
