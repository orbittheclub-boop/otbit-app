import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:orbit/core/l10n/auth_error.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/theme/dark_mode_icon_button.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/auth/presentation/providers/recent_emails.dart';
import 'package:orbit/features/auth/presentation/widgets/password_field.dart';
import 'package:orbit/features/auth/presentation/widgets/social_button.dart';
import 'package:orbit/features/home/presentation/widgets/language_tile.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final emailFocus = useFocusNode();
    final loading = useState(false);
    final error = useState<String?>(null);
    useListenable(emailFocus); // rebuild on focus to show/hide suggestions
    useListenable(email); // rebuild to filter suggestions

    final recent = ref.watch(recentEmailsProvider);
    final q = email.text.trim().toLowerCase();
    final suggestions = recent
        .where((e) => e != email.text.trim() && e.toLowerCase().contains(q))
        .toList();
    final showSuggestions = emailFocus.hasFocus && suggestions.isNotEmpty;

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      loading.value = true;
      error.value = null;
      final err = await ref
          .read(authControllerProvider.notifier)
          .signIn(email.text.trim(), password.text);
      if (!context.mounted) return;
      loading.value = false;
      if (err == null) {
        // Remember the email for next time's quick-pick.
        ref.read(recentEmailsProvider.notifier).add(email.text.trim());
      }
      // Localize Supabase/network errors to the selected language.
      error.value = err == null ? null : localizeAuthError(context.l10n, err);
    }

    // Shared runner for the native Apple/Google flows (each returns an error
    // string or null). On success the auth state changes and the router
    // redirects away from this screen.
    Future<void> social(Future<String?> Function() run) async {
      if (loading.value) return;
      FocusScope.of(context).unfocus();
      loading.value = true;
      error.value = null;
      final err = await run();
      if (!context.mounted) return;
      loading.value = false;
      // Repo throws error codes (canceled / *_failed / network) — localize them.
      error.value = err == null ? null : localizeAuthError(context.l10n, err);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  const SizedBox(height: 72),
                  const Text(
                    'Orbit',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .moveY(begin: -18, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.appTagline,
                    style: TextStyle(
                      color: context.palette.textSecondary,
                      fontSize: 15,
                    ),
                  ).animate(delay: 120.ms).fadeIn(duration: 450.ms),
                  const SizedBox(height: 44),
                  TextField(
                    controller: email,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: context.l10n.email),
                  ),
                  // Quick-pick recently used emails; X removes a saved one.
                  if (showSuggestions)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: context.palette.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.palette.border),
                      ),
                      child: Column(
                        children: [
                          for (final e in suggestions)
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      email.text = e;
                                      emailFocus.unfocus();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 12),
                                      child: Row(
                                        children: [
                                          Icon(Icons.history_rounded,
                                              size: 16,
                                              color:
                                                  context.palette.textTertiary),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(e,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close_rounded,
                                      size: 18),
                                  color: context.palette.textTertiary,
                                  onPressed: () => ref
                                      .read(recentEmailsProvider.notifier)
                                      .remove(e),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                  PasswordField(
                    controller: password,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => submit(),
                  ),
                  // Fixed-height error slot — reserved from the start so the
                  // button never shifts when a message appears.
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 34,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: error.value != null
                          ? Text(
                              error.value!,
                              maxLines: 2,
                              style: const TextStyle(
                                color: AppColors.danger,
                                fontSize: 13,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    label: context.l10n.login,
                    loading: loading.value,
                    onPressed: submit,
                  ),
                  const SizedBox(height: 20),
                  // "또는" divider between email and social sign-in.
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: context.palette.border),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          context.l10n.orDivider,
                          style: TextStyle(
                            color: context.palette.textTertiary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: context.palette.border),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SocialButton.apple(
                    label: context.l10n.continueWithApple,
                    isDark: isDark,
                    onPressed: loading.value
                        ? null
                        : () => social(() => ref
                            .read(authControllerProvider.notifier)
                            .signInWithApple()),
                  ),
                  const SizedBox(height: 12),
                  SocialButton.google(
                    label: context.l10n.continueWithGoogle,
                    isDark: isDark,
                    surface: context.palette.surface,
                    border: context.palette.border,
                    foreground: context.palette.ink,
                    onPressed: loading.value
                        ? null
                        : () => social(() => ref
                            .read(authControllerProvider.notifier)
                            .signInWithGoogle()),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.pushReplacement('/signup'),
                    child: Text(context.l10n.signupWithEmail),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 4,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/welcome'),
              ),
            ),
            const Positioned(
              top: 0,
              right: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [LanguageIconButton(), DarkModeIconButton()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
