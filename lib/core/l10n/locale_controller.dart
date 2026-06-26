import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/theme/theme_controller.dart';

part 'locale_controller.g.dart';

/// Selected app locale (null = follow system), persisted.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.read(sharedPreferencesProvider).getString(_key);
    return code == null ? null : Locale(code);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
  }
}

/// Supported locales: (locale, flag emoji, native name). For the picker.
const supportedLanguages = <(Locale, String, String)>[
  (Locale('ko'), '🇰🇷', '한국어'),
  (Locale('en'), '🇺🇸', 'English'),
  (Locale('ja'), '🇯🇵', '日本語'),
  (Locale('es'), '🇪🇸', 'Español'),
];
