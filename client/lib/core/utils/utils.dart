import 'package:flutter/material.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:app_settings/app_settings.dart';

String rgbToHex(Color color) {
  return '#${color.red.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

void pickAudio() async {
  try {
    final filePickerRes =
        await FilePicker.platform.pickFiles(type: FileType.audio);
  } catch (e) {}
}

Future<void> photoDenied(BuildContext context) async => await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Photo access required'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Open settings to allow access',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Settings'),
              onPressed: () async {
                await AppSettings.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
