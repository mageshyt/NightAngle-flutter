import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/widgets/button.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Sizes.buttonHeight + 5,
      child: Button(
        text: buttonText,
        onPressed: onTap,
        customStyle: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
