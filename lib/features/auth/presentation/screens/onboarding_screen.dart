import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/phone_number_formatter.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/domain/entities/onboarding_input.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/auth/presentation/widgets/role_card.dart';

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
        error.value = context.l10n.selectRole;
        return;
      }
      if (name.text.trim().isEmpty) {
        error.value = isCompany
            ? context.l10n.enterCompanyName
            : context.l10n.enterNickname;
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
      // resizeToAvoidBottomInset stays true (default): the body shrinks to the
      // area above the keyboard so Flutter auto-scrolls the focused field (e.g.
      // the bottom 연락처 field) into view instead of leaving it covered.
      appBar: AppBar(
        title: Text(context.l10n.profileSetup),
        // No role yet → the only way "back" is to abandon signup (sign out),
        // which returns to the welcome screen.
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: context.l10n.cancel,
          onPressed: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(context.l10n.onboardCancelTitle),
                content: Text(context.l10n.onboardCancelBody),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text(context.l10n.continueLabel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text(context.l10n.onboardLeave),
                  ),
                ],
              ),
            );
            if (ok == true) {
              await ref.read(authControllerProvider.notifier).signOut();
            }
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(height: 8),
              Text(
                context.l10n.onboardingTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.palette.ink,
                  height: 1.3,
                ),
              ),
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
              if (role.value != null) ...[
                const SizedBox(height: 28),
                Text(
                  isCompany ? context.l10n.companyName : context.l10n.nickname,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.palette.ink,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: isCompany
                        ? context.l10n.onboardCompanyNameHint
                        : context.l10n.onboardNicknameHint,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.contactOptional,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.palette.ink,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [PhoneNumberFormatter()],
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
                label: context.l10n.start,
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
