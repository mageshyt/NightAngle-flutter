import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nightAngle/core/theme/text-style.dart';
import 'package:nightAngle/features/auth/model/user-model.dart';

import 'package:nightAngle/core/core.dart';

class SongsPageHeader extends StatelessWidget {
  final UserModel? user;
  const SongsPageHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // greeting and user name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Evening 👋',
              style: TextStyles.greetingStyle,
            ),
            Text(user!.name,
                style: const TextStyle(
                  fontSize: Sizes.fontSizeMd,
                  color: Pallete.white,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),

        // search icon

        const Spacer(),

        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          icon: const Icon(IconlyLight.search),
          color: Pallete.white,
        ),

        // notification icon
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          icon: const Icon(CupertinoIcons.bell),
          color: Pallete.white,
        ),
      ],
    );
  }
}
