import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'package:orbit/core/theme/app_colors.dart';

enum AppToastType { success, error, info }

/// App-wide toast anchored to the TOP so it never covers bottom action buttons
/// (e.g. the apply/cancel button on the campaign detail). Auto-dismisses.
void showAppToast(
  BuildContext context,
  String message, {
  AppToastType type = AppToastType.success,
}) {
  toastification.show(
    context: context,
    type: switch (type) {
      AppToastType.success => ToastificationType.success,
      AppToastType.error => ToastificationType.error,
      AppToastType.info => ToastificationType.info,
    },
    style: ToastificationStyle.flatColored,
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(milliseconds: 2400),
    showProgressBar: false,
    borderRadius: BorderRadius.circular(14),
    primaryColor: type == AppToastType.success ? AppColors.primary : null,
    title: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
