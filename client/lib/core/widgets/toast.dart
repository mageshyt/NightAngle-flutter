import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:nightAngle/core/theme/text-style.dart';

enum Toasttype { error, info, warning, success, custom }

class toast {
  static showToast({
    required BuildContext context,
    required String title,
    IconData? icon,
    ToastPosition? toastPosition,
    Alignment? toastAlignment,
  }) {
    SlidingToast.show(
      context,
      title: Text(
        title,
        style: const TextStyle(),
      ),
      trailing: Icon(icon, color: Colors.deepPurple),
      toastSetting: ToastSetting(
        animationDuration: const Duration(seconds: 1),
        displayDuration: const Duration(seconds: 2),
        toastStartPosition: toastPosition ?? ToastPosition.right,
        toastAlignment: toastAlignment ?? Alignment.topCenter,
      ),
    );
  }

  static showErrorToast({
    required BuildContext context,
    required String message,
    ToastPosition? toastPosition,
    Alignment? toastAlignment,
  }) {
    SlidingToast.showError(
      context,
      title: Text(
        message,
        style: TextStyles.toastStyle,
      ),
      toastSetting: ToastSetting(
        toastStartPosition: toastPosition ?? ToastPosition.right,
        toastAlignment: toastAlignment ?? Alignment.topCenter,
      ),
    );
  }

  static showSuccessToast({
    required BuildContext context,
    required String message,
    ToastPosition? toastPosition,
    Alignment? toastAlignment,
  }) {
    SlidingToast.showSuccess(
      context,
      title: Text(
        message,
        style: TextStyles.toastStyle,
      ),
      toastSetting: ToastSetting(
        toastStartPosition: ToastPosition.top,
        toastAlignment: toastAlignment ?? Alignment.topCenter,
      ),
    );
  }

  static showCustomToast({
    required BuildContext context,
    required Widget customWidget,
    ToastPosition? toastPosition,
    Alignment? toastAlignment,
    required Color bgcolor,
  }) {
    SlidingToast.show(
      context,
      title: customWidget,
      toastSetting: const ToastSetting(
        maxHeight: 140,
        animationDuration: Duration(seconds: 1),
        displayDuration: Duration(seconds: 5),
        showReverseAnimation: true,
        showProgressBar: false,
        toastStartPosition: ToastPosition.left,
        toastAlignment: Alignment.center,
      ),
      toastStyle: ToastStyle(
        backgroundColor: bgcolor,
        boxShadow: [
          BoxShadow(
            color: bgcolor.withOpacity(.2),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
    );
  }
}
