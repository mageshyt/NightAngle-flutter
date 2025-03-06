import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
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

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final currentUser = ref.watch(currentUserNotifierProvider);

  return GoRouter(
    navigatorKey: _key,

    /// Forwards diagnostic messages to the dart:developer log() API.
    debugLogDiagnostics: true,

    /// Initial Routing Location
    initialLocation: Routes.home,

    routes: [
      // Define a default route p
      GoRoute(
        name: RoutesName.home,
        path: Routes.home,
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

    redirect: (context, state) {
      //  check if the user is logged in
      final isAuthenticated = currentUser != null;

      LoggerHelper.debug('Current User ROUTE: $currentUser');

      // if the user is not logged in and he can try to access login page and register page
      if (!isAuthenticated && state.fullPath == Routes.login) {
        return Routes.login;
      }

      if (!isAuthenticated && state.fullPath == Routes.register) {
        return Routes.register;
      }

      // if user is logged in and he can try to access protected routes
      if (!isAuthenticated) {
        return Routes.login;
      }
      // null - redirect to initial location
      return null;
    },
  );
});
