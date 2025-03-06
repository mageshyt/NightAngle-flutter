import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nightAngle/core/core.dart';

class RotatingDisk extends StatefulWidget {
  const RotatingDisk({super.key});

  @override
  State createState() => _RotatingDiskState();
}

class _RotatingDiskState extends State<RotatingDisk>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Duration for one full rotation
    )..repeat(); // Repeat the animation forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        'assets/icons/disk.svg',
        width: 30,
        height: 30,
        color: Pallete.white,
      ),
    );
  }
}
