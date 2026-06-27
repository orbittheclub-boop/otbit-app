import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';

/// Password input with a show/hide (eye) toggle.
class PasswordField extends HookWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.hint,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String? hint;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final obscure = useState(true);
    return TextField(
      controller: controller,
      obscureText: obscure.value,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hint ?? context.l10n.password,
        suffixIcon: IconButton(
          tooltip: obscure.value
              ? context.l10n.showPassword
              : context.l10n.hidePassword,
          icon: Icon(
            obscure.value
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: context.palette.textTertiary,
            size: 22,
          ),
          onPressed: () => obscure.value = !obscure.value,
        ),
      ),
    );
  }
}
