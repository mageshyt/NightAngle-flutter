import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/auth/view/pages/signin-page.dart';
import 'package:nightAngle/features/auth/view/pages/signup-page.dart';
import 'package:nightAngle/features/home/view/pages/home-page.dart';
import 'package:nightAngle/features/home/view/pages/upload-song-page.dart';
import 'package:nightAngle/features/home/view/pages/music-player.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: Routes.home,
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
          pageBuilder: (
            context,
            state,
          ) =>
              const MaterialPage(
            child: UploadSongPage(),
          ),
        ),

        GoRoute(
          name: RoutesName.musicPlay,
          path: Routes.musicPlay,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final slideTween = Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(
                CurveTween(curve: Curves.easeInOut),
              );

              final fadeTween = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).chain(
                CurveTween(curve: Curves.easeIn),
              );

              final slideAnimation = animation.drive(slideTween);
              final fadeAnimation = animation.drive(fadeTween);

              return SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: child,
                ),
              );
            },
            key: state.pageKey,
            child: const MusicPlayer(),
            transitionDuration: const Duration(milliseconds: 500),
          ),
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
