import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightAngle/core/core.dart';

class Loader extends StatelessWidget {
  final double size;
  final Color color;
  const Loader({
    super.key,
    this.size = 50,
    this.color = Pallete.primary,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: color,
      size: size,
    );
  }
}
