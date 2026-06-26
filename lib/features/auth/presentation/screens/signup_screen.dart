import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/auth_error.dart';
import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/auth/presentation/widgets/password_field.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final confirm = useTextEditingController();
    final loading = useState(false);
    final error = useState<String?>(null);

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      if (password.text.length < 6) {
        error.value = context.l10n.passwordMin6;
        return;
      }
      if (password.text != confirm.text) {
        error.value = context.l10n.passwordMismatch;
        return;
      }
      loading.value = true;
      error.value = null;
      final err = await ref
          .read(authControllerProvider.notifier)
          .signUp(email.text.trim(), password.text);
      if (!context.mounted) return;
      loading.value = false;
      // Localize Supabase/network errors to the selected language.
      error.value = err == null ? null : localizeAuthError(context.l10n, err);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              Text(
                '이메일과 비밀번호로\n계정을 만들어주세요',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.palette.ink,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(hintText: '이메일'),
              ),
              const SizedBox(height: 12),
              PasswordField(
                controller: password,
                hint: '비밀번호 (6자 이상)',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              PasswordField(
                controller: confirm,
                hint: '비밀번호 확인',
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => submit(),
              ),
              // Fixed-height error slot — reserved from the start so the button
              // never shifts when a message appears.
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
                              color: AppColors.danger, fontSize: 13),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: context.l10n.continueLabel,
                loading: loading.value,
                onPressed: submit,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.pushReplacement('/login'),
                child: const Text('이미 계정이 있어요'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
