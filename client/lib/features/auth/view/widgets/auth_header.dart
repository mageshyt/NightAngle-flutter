import 'package:client/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/logo.svg',
          height: 80,
        ),
        const SizedBox(height: Sizes.spaceBtwItems),
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.fontSizexl,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: Sizes.fontSizeMd,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
