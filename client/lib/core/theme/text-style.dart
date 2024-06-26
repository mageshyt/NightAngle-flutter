import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle labelStyle = TextStyle(
    fontSize: Sizes.fontSizeMd,
    color: Pallete.grey,
  );

  static const TextStyle toastStyle = TextStyle(
    fontSize: Sizes.fontSizeMd,
    color: Pallete.black,
  );

  static const TextStyle greetingStyle = TextStyle(
    fontSize: Sizes.fontSizeLg,
    color: Pallete.darkGrey,
    fontWeight: FontWeight.w400,
  );

  static TextStyle sectionHeading = TextStyle(
    color: Pallete.white,
    fontSize: Sizes.fontSizeXLg,
    fontWeight: FontWeight.bold,
    shadows: [
      BoxShadow(
        color: Pallete.white.withOpacity(1),
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  static TextStyle songTitle = const TextStyle(
    color: Pallete.white,
    fontSize: Sizes.fontSizeXLg,
    fontWeight: FontWeight.w700,
  );
}
