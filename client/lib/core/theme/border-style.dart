import 'package:flutter/material.dart';
import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';

class BorderStyles {
  const BorderStyles._();

  // outline border

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
    gapPadding: 10,
    borderSide: const BorderSide(color: Pallete.borderColor, width: 3),
  );

  static OutlineInputBorder outlineInputBorderFocused = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
    borderSide: const BorderSide(color: Pallete.primary, width: 3),
  );

  static OutlineInputBorder outlineInputBorderEnabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
    borderSide: const BorderSide(color: Pallete.borderColor, width: 3),
  );

  static OutlineInputBorder outlineErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
    borderSide: const BorderSide(color: Colors.redAccent, width: 3),
  );

  // Empty border style
  static InputDecoration emptyBorder = const InputDecoration(
      contentPadding: EdgeInsets.zero,
      labelText: 'Image',
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      helperText: '');
}
