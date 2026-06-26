import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/theme/app_theme.dart';
import 'package:orbit/core/theme/theme_controller.dart';

/// Sun/moon dark-mode toggle with an animated circular reveal transition.
class DarkModeIconButton extends ConsumerWidget {
  const DarkModeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeSwitcher.withTheme(
      builder: (context, switcher, theme) {
        final isDark = theme.brightness == Brightness.dark;
        return IconButton(
          tooltip: isDark ? '라이트 모드' : '다크 모드',
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: context.palette.textSecondary,
          ),
          onPressed: () {
            switcher.changeTheme(theme: isDark ? AppTheme.light : AppTheme.dark);
            ref
                .read(themeModeControllerProvider.notifier)
                .set(isDark ? ThemeMode.light : ThemeMode.dark);
          },
        );
      },
    );
  }
}
