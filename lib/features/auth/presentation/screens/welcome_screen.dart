import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/theme/dark_mode_icon_button.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/home/presentation/widgets/language_tile.dart';

/// First screen for signed-out users: brand + 로그인 / 회원가입.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              right: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [LanguageIconButton(), DarkModeIconButton()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      gradient: AppColors.brandGradient,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome_rounded,
                        color: AppColors.onPrimary, size: 40),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
                  const SizedBox(height: 28),
                  const Text(
                    'Orbit',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: -0.5,
                    ),
                  ).animate(delay: 120.ms).fadeIn(duration: 450.ms).moveY(
                        begin: 14,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      ),
                  const SizedBox(height: 10),
                  Text(
                    context.l10n.welcomeSubtitle,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: context.palette.textSecondary,
                    ),
                  ).animate(delay: 240.ms).fadeIn(duration: 450.ms),
                  const Spacer(flex: 4),
                  PrimaryButton(
                    label: context.l10n.login,
                    onPressed: () => context.push('/login'),
                  ).animate(delay: 320.ms).fadeIn(duration: 400.ms).moveY(
                        begin: 16,
                        end: 0,
                        curve: Curves.easeOut,
                      ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: context.l10n.signup,
                    onPressed: () => context.push('/signup'),
                  ).animate(delay: 400.ms).fadeIn(duration: 400.ms).moveY(
                        begin: 16,
                        end: 0,
                        curve: Curves.easeOut,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
