import 'package:nightAngle/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nightAngle/core/theme/app_pallete.dart';

// Enums for button variants and sizes
enum ButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ButtonSize {
  defaultSize,
  sm,
  lg,
  icon,
}

class Button extends StatelessWidget {
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final Widget? label;
  final String? text;
  final void Function()? onPressed;
  final ButtonStyle? customStyle;

  const Button({
    Key? key,
    this.variant = ButtonVariant.defaultVariant,
    this.size = ButtonSize.defaultSize,
    this.icon,
    this.label,
    this.text,
    this.onPressed,
    this.customStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    // override the buttonStyle with customStyle if it is not null
    final mergedStyle =
        customStyle != null ? customStyle!.merge(buttonStyle) : buttonStyle;

    switch (variant) {
      case ButtonVariant.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: mergedStyle,
          child: _buildChild(),
        );
      case ButtonVariant.ghost:
      case ButtonVariant.link:
        return TextButton(
          onPressed: onPressed,
          style: mergedStyle,
          child: _buildChild(),
        );
      default:
        return ElevatedButton(
          onPressed: onPressed,
          style: mergedStyle,
          child: _buildChild(),
        );
    }
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusSm),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: _getFontSize(size),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(_getPadding(size)),
    ).merge(customStyle);

    switch (variant) {
      case ButtonVariant.defaultVariant:
        return baseStyle.copyWith(
          backgroundColor:
              WidgetStateProperty.all<Color>(Pallete.buttonPrimary),
          foregroundColor: WidgetStateProperty.all<Color>(Pallete.white),
          overlayColor:
              WidgetStateProperty.all<Color>(Pallete.primary.withOpacity(0.8)),
        );
      case ButtonVariant.destructive:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(Pallete.error),
          foregroundColor: WidgetStateProperty.all<Color>(Pallete.white),
          overlayColor:
              WidgetStateProperty.all<Color>(Pallete.error.withOpacity(0.8)),
        );
      case ButtonVariant.outline:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(Pallete.transparent),
          foregroundColor:
              WidgetStateProperty.all<Color>(Pallete.backgroundColor),
          side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: Pallete.white)),
          overlayColor:
              WidgetStateProperty.all<Color>(Pallete.darkGrey.withOpacity(0.2)),
          elevation: WidgetStateProperty.all<double>(0),
        );
      case ButtonVariant.secondary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(Pallete.white),
          foregroundColor: WidgetStateProperty.all<Color>(Pallete.black),
          overlayColor:
              WidgetStateProperty.all<Color>(Pallete.darkGrey.withOpacity(0.8)),
        );
      case ButtonVariant.ghost:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(Pallete.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(Pallete.white),
          elevation: WidgetStateProperty.all<double>(0),
          overlayColor: WidgetStateProperty.all<Color>(Pallete.textPrimary),
        );
      case ButtonVariant.link:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(Pallete.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(Pallete.primary),
          overlayColor:
              WidgetStateProperty.all<Color>(Pallete.primary.withOpacity(0.2)),
        );
      default:
        return baseStyle;
    }
  }

  EdgeInsetsGeometry _getPadding(ButtonSize size) {
    switch (size) {
      case ButtonSize.defaultSize:
        return const EdgeInsets.symmetric(
            horizontal: Sizes.md, vertical: Sizes.sm);
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(
            horizontal: Sizes.md, vertical: Sizes.sm);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(
            horizontal: Sizes.lg, vertical: Sizes.md);
      case ButtonSize.icon:
        return const EdgeInsets.all(Sizes.sm);
      default:
        return const EdgeInsets.symmetric(
            horizontal: Sizes.md, vertical: Sizes.sm);
    }
  }

  double _getFontSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.defaultSize:
        return Sizes.md;
      case ButtonSize.sm:
        return Sizes.sm;
      case ButtonSize.lg:
        return Sizes.md;
      case ButtonSize.icon:
        return Sizes.sm;
      default:
        return Sizes.md;
    }
  }

  Widget _buildChild() {
    if (text != null) {
      return Text(text!);
    } else if (icon != null && label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          label!,
        ],
      );
    } else if (icon != null) {
      return icon!;
    } else if (label != null) {
      return label!;
    } else {
      return Container();
    }
  }
}
