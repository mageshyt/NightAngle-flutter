import 'package:client/core/core.dart';
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          backgroundColor: Pallete.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
          ),
          textStyle: const TextStyle(
            fontSize: Sizes.fontSizeLg,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}
