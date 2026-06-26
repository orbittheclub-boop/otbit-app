import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/theme/app_theme.dart';
import 'package:orbit/core/theme/theme_controller.dart';

class DarkModeTile extends ConsumerWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeSwitcher.withTheme(
      builder: (context, switcher, theme) {
        final isDark = theme.brightness == Brightness.dark;
        return SwitchListTile(
          secondary:
              const Icon(Icons.dark_mode_outlined, color: AppColors.primary),
          title: Text(context.l10n.darkMode),
          value: isDark,
          activeThumbColor: AppColors.primary,
          onChanged: (v) {
            switcher.changeTheme(theme: v ? AppTheme.dark : AppTheme.light);
            ref
                .read(themeModeControllerProvider.notifier)
                .set(v ? ThemeMode.dark : ThemeMode.light);
          },
        );
      },
    );
  }
}
