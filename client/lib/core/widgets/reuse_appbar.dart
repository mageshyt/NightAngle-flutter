import 'package:flutter/material.dart';
import 'package:nightAngle/core/core.dart';

class ReuseableAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isCenterTitle;
  final Color? backgroundColor;
  final bool? isBackButton;

  const ReuseableAppbar({
    super.key,
    this.title,
    this.isCenterTitle = true,
    this.backgroundColor,
    this.isBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      centerTitle: isCenterTitle,
      leading: isBackButton == true
          ? Button(
              icon: const Icon(Icons.arrow_back),
              variant: ButtonVariant.icon,
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
