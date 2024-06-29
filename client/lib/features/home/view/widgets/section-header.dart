import 'package:flutter/cupertino.dart';
import 'package:nightAngle/core/core.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool? isMoreVisible;
  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
    this.isMoreVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Pallete.white,
              fontSize: Sizes.fontSizeLg,
              fontWeight: FontWeight.bold,
              shadows: [
                BoxShadow(
                  color: Pallete.white.withOpacity(0.9),
                  blurRadius: 50,
                  offset: Offset(0, 3),
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 10,
                ),
              ]),
        ),
        const Spacer(),
        if (isMoreVisible!)
          Button(
            onPressed: onTap,
            variant: ButtonVariant.ghost,
            label: const Text(
              'View All',
              style: TextStyle(
                color: Pallete.subtitleText,
                fontSize: Sizes.fontSizesm,
              ),
            ),
          ),
      ],
    );
  }
}
