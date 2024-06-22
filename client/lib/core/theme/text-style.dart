import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle labelStyle = TextStyle(
    fontSize: Sizes.fontSizeMd,
    color: Pallete.subtitleText,
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

  static const TextStyle sectionHeading = TextStyle(
    color: Pallete.white,
    fontSize: Sizes.fontSizeXLg,
    fontWeight: FontWeight.bold,

  );
}
