import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nightAngle/core/core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';

import 'package:nightAngle/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:nightAngle/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // -----------------GetStorage-------------------
  await GetStorage.init();
  //-----------------Hive-------------------
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;

//  -----------------Just Audio------------------
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  // -----------------Riverpod-------------------

  final container = ProviderContainer();

  var connectivityResult = await Connectivity().checkConnectivity();
  // if (connectivityResult. ConnectivityResult.none) {
  //   LoggerHelper.debug('No internet connection');
  // }
  LoggerHelper.debug(connectivityResult.toString());

  await container.read(authViewModelProvider.notifier).getCurrentUser();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Night Angle',
      theme: AppTheme.darkThemeMode,
      routerConfig: AppRouter.returnRouter(
        false,
      ),
    );
  }
}
