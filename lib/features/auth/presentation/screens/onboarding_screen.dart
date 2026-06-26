import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = useState<Role?>(null);
    final name = useTextEditingController();
    final phone = useTextEditingController();
    final loading = useState(false);
    final error = useState<String?>(null);

    final isCompany = role.value == Role.company;
    final isInfluencer = role.value == Role.influencer;

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      if (role.value == null) {
        error.value = '역할을 선택해주세요.';
        return;
      }
      if (name.text.trim().isEmpty) {
        error.value = isCompany ? '회사명을 입력해주세요.' : '닉네임을 입력해주세요.';
        return;
      }
      loading.value = true;
      error.value = null;
      final r = role.value!;
      final input = OnboardingInput(
        role: r,
        displayName: name.text.trim(),
        phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
        companyName: isCompany ? name.text.trim() : null,
        nickname: isInfluencer ? name.text.trim() : null,
      );
      final err = await ref
          .read(authControllerProvider.notifier)
          .completeOnboarding(input);
      if (!context.mounted) return;
      loading.value = false;
      error.value = err; // null on success — router routes to the role home
    }

    return Scaffold(
      // Keep the body full-height; the ListView's dynamic bottom padding (the
      // keyboard height) gives the focused field room to scroll ABOVE the
      // keyboard, then settles back when it unfocuses.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('프로필 설정')),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              24,
              8,
              24,
              MediaQuery.viewInsetsOf(context).bottom + 28,
            ),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(height: 8),
              Text(
                '어떤 목적으로\n사용하실 건가요?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.palette.ink,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),
              _RoleCard(
                title: '회사 · 브랜드',
                subtitle: '캠페인을 등록하고 인플루언서를 모집해요',
                icon: Icons.business_rounded,
                selected: isCompany,
                onTap: () => role.value = Role.company,
              ),
              const SizedBox(height: 12),
              _RoleCard(
                title: '인플루언서',
                subtitle: 'TikTok을 연동하고 캠페인에 지원해요',
                icon: Icons.auto_awesome_rounded,
                selected: isInfluencer,
                onTap: () => role.value = Role.influencer,
              ),
              if (role.value != null) ...[
                const SizedBox(height: 28),
                Text(
                  isCompany ? '회사명' : '닉네임',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.palette.ink,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: isCompany ? '예) 오비트 코스메틱' : '예) 오비트지기',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '연락처 (선택)',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.palette.ink,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: '010-0000-0000'),
                ),
              ],
              if (error.value != null) ...[
                const SizedBox(height: 14),
                Text(
                  error.value!,
                  style: const TextStyle(color: AppColors.danger, fontSize: 13),
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(
                label: '시작하기',
                loading: loading.value,
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? context.palette.primarySoft : context.palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : context.palette.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : context.palette.textSecondary,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.palette.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.palette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
