import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

import 'package:orbit/core/cache/board_cache.dart';
import 'package:orbit/core/cache/bookmark_cache.dart';
import 'package:orbit/core/config/env.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/notification/presentation/providers/push_pref_controller.dart';
import 'package:orbit/firebase_options.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/l10n/locale_controller.dart';
import 'package:orbit/core/router/app_router.dart';
import 'package:orbit/core/theme/app_theme.dart';
import 'package:orbit/core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabasePublishableKey,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  await BoardCache.init();
  await BookmarkCache.init();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const OrbitApp(),
    ),
  );
}

class OrbitApp extends HookConsumerWidget {
  const OrbitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final locale = ref.watch(localeControllerProvider);
    // Initial theme from the saved preference; runtime switching is animated
    // via ThemeSwitcher (animated_theme_switcher).
    final initIsDark =
        ref.read(themeModeControllerProvider) == ThemeMode.dark;

    // When a user lands in the app (right after onboarding, or on later
    // launches), ensure push permission + token registration and persist the
    // on/off state. iOS only shows the prompt the first time — so this reads as
    // a natural "allow notifications?" right after finishing onboarding.
    ref.listen(authControllerProvider, (prev, next) {
      final user = next.value;
      if (user != null && user.role != null) {
        ref.read(pushPrefControllerProvider.notifier).ensureRegistered();
      }
    });

    // App-wide: whenever the app returns to the foreground, reconcile the push
    // toggle with the real OS permission (the user may have changed it in
    // Settings). Doing it here — not just on the profile screen — keeps the
    // stored state in sync regardless of which screen is showing.
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) {
        ref.read(pushPrefControllerProvider.notifier).syncFromSystem();
      }
    });

    return ToastificationWrapper(
      child: ThemeProvider(
        initTheme: initIsDark ? AppTheme.dark : AppTheme.light,
        builder: (_, theme) => MaterialApp.router(
        title: 'Orbit',
        debugShowCheckedModeBanner: false,
        theme: theme,
        locale: locale,
        localizationsDelegates: [
          ...AppLocalizations.localizationsDelegates,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        // Tap anywhere outside an input to dismiss the keyboard.
        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
      ),
    );
  }
}
