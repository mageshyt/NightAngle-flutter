import 'package:flutter/material.dart';
import 'package:nightAngle/core/core.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Loader(),

          // text

          Text(
            'uploading the song',
  

          )
        ],
      ),
    );
  }
}
