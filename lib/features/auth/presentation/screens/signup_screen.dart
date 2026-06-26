import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/auth_error.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/phone_number_formatter.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/auth/presentation/widgets/password_field.dart';
import 'package:orbit/features/auth/presentation/widgets/role_card.dart';
import 'package:orbit/features/auth/presentation/widgets/social_button.dart';

/// Signup wizard. The account is created LAST: first pick a role and fill in the
/// profile, then on the final step choose email or social sign-up. The chosen
/// method creates the account and submits the collected onboarding info in one
/// shot (see [AuthController.signUpWithEmailAndOnboard] etc.).
class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = useState(0);
    final role = useState<Role?>(null);
    final name = useTextEditingController();
    final phone = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final confirm = useTextEditingController();
    final loading = useState(false);
    final error = useState<String?>(null);
    useListenable(name); // rebuild to enable/disable the Next button

    final isCompany = role.value == Role.company;
    final isInfluencer = role.value == Role.influencer;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ctrl = ref.read(authControllerProvider.notifier);

    OnboardingInput buildInput() => OnboardingInput(
          role: role.value!,
          displayName: name.text.trim(),
          phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
          companyName: isCompany ? name.text.trim() : null,
          nickname: isInfluencer ? name.text.trim() : null,
        );

    // Runs a finishing action (account + onboarding). On success the auth state
    // changes and the router routes to the role home — nothing to do here.
    Future<void> run(
      Future<String?> Function() action, {
      bool localize = false,
    }) async {
      FocusScope.of(context).unfocus();
      loading.value = true;
      error.value = null;
      final err = await action();
      if (!context.mounted) return;
      loading.value = false;
      if (err == null) return;
      error.value = localize ? localizeAuthError(context.l10n, err) : err;
    }

    void emailSignup() {
      if (password.text.length < 6) {
        error.value = context.l10n.passwordMin6;
        return;
      }
      if (password.text != confirm.text) {
        error.value = context.l10n.passwordMismatch;
        return;
      }
      run(
        () => ctrl.signUpWithEmailAndOnboard(
          email: email.text.trim(),
          password: password.text,
          input: buildInput(),
        ),
        localize: true,
      );
    }

    void back() {
      error.value = null;
      if (step.value > 0) {
        step.value -= 1;
      } else {
        context.canPop() ? context.pop() : context.go('/welcome');
      }
    }

    final children = switch (step.value) {
      0 => [
          _Title(context.l10n.onboardingTitle),
          const SizedBox(height: 24),
          RoleCard(
            title: context.l10n.roleCompany,
            subtitle: context.l10n.roleCompanyDesc,
            icon: Icons.business_rounded,
            selected: isCompany,
            onTap: () => role.value = Role.company,
          ),
          const SizedBox(height: 12),
          RoleCard(
            title: context.l10n.roleInfluencer,
            subtitle: context.l10n.roleInfluencerDesc,
            icon: Icons.auto_awesome_rounded,
            selected: isInfluencer,
            onTap: () => role.value = Role.influencer,
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: context.l10n.next,
            onPressed: role.value == null ? null : () => step.value = 1,
          ),
        ],
      1 => [
          _Title(context.l10n.profileStepTitle),
          const SizedBox(height: 24),
          _Label(isCompany ? context.l10n.companyName : context.l10n.nickname),
          const SizedBox(height: 8),
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: isCompany ? '예) 오비트 코스메틱' : '예) 오비트지기',
            ),
          ),
          const SizedBox(height: 16),
          _Label(context.l10n.contactOptional),
          const SizedBox(height: 8),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            inputFormatters: [PhoneNumberFormatter()],
            decoration: const InputDecoration(hintText: '010-0000-0000'),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: context.l10n.next,
            onPressed:
                name.text.trim().isEmpty ? null : () => step.value = 2,
          ),
        ],
      _ => [
          _Title(context.l10n.signupMethodTitle),
          const SizedBox(height: 24),
          SocialButton.apple(
            label: context.l10n.continueWithApple,
            isDark: isDark,
            onPressed: loading.value
                ? null
                : () => run(() => ctrl.signUpWithAppleAndOnboard(buildInput())),
          ),
          const SizedBox(height: 12),
          SocialButton.google(
            label: context.l10n.continueWithGoogle,
            isDark: isDark,
            surface: Theme.of(context).colorScheme.surface,
            border: context.palette.border,
            foreground: context.palette.ink,
            onPressed: loading.value
                ? null
                : () =>
                    run(() => ctrl.signUpWithGoogleAndOnboard(buildInput())),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider(color: context.palette.border)),
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
              Expanded(child: Divider(color: context.palette.border)),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: InputDecoration(hintText: context.l10n.email),
          ),
          const SizedBox(height: 12),
          PasswordField(
            controller: password,
            hint: context.l10n.passwordHint6,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          PasswordField(
            controller: confirm,
            hint: context.l10n.passwordConfirm,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => emailSignup(),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: context.l10n.signupWithEmail,
            loading: loading.value,
            onPressed: emailSignup,
          ),
        ],
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: back,
        ),
        title: Text(context.l10n.signup),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _StepDots(current: step.value, total: 3),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  ...children,
                  // Fixed-height error slot under the content.
                  const SizedBox(height: 14),
                  if (error.value != null)
                    Text(
                      error.value!,
                      style: const TextStyle(
                          color: AppColors.danger, fontSize: 13),
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

class _Title extends StatelessWidget {
  const _Title(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: context.palette.ink,
        height: 1.3,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: context.palette.ink,
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.current, required this.total});
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < total; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == current ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i <= current
                    ? AppColors.primary
                    : context.palette.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
