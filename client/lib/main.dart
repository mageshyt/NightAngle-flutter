import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:nightAngle/router.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final container = ProviderContainer();

  await container.read(authViewModelProvider.notifier).getCurrentUser();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);

    LoggerHelper.debug(currentUser.toString());

    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: 'Night Angle',
      theme: AppTheme.darkThemeMode,

      routerConfig: AppRouter.returnRouter(
        currentUser != null,
      ),
    );
  }
}
