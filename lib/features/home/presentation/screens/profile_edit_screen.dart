import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';

/// Edit the current user's avatar + display name (nickname for influencers,
/// company name for companies). Avatar bytes go to the `avatar` Edge Function
/// (compressed to WebP); the name is saved via PATCH /profile.
class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final isCompany = user?.role == Role.company;

    final name = useTextEditingController(text: user?.displayName ?? '');
    final saving = useState(false);
    final uploading = useState(false);
    final error = useState<String?>(null);
    useListenable(name);

    Future<void> pickAvatar() async {
      final x = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
      if (x == null) return;
      uploading.value = true;
      error.value = null;
      final bytes = await x.readAsBytes();
      final ct = x.name.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';
      final err =
          await ref.read(authControllerProvider.notifier).changeAvatar(bytes, ct);
      if (!context.mounted) return;
      uploading.value = false;
      if (err != null) error.value = err;
    }

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      final value = name.text.trim();
      if (value.isEmpty) {
        error.value = isCompany
            ? context.l10n.enterCompanyName
            : context.l10n.enterNickname;
        return;
      }
      saving.value = true;
      error.value = null;
      final patch = <String, dynamic>{
        'display_name': value,
        if (isCompany) 'company_name': value else 'nickname': value,
      };
      final err =
          await ref.read(authControllerProvider.notifier).updateProfile(patch);
      if (!context.mounted) return;
      saving.value = false;
      if (err != null) {
        error.value = err;
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.profileUpdated)),
      );
      context.pop();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(context.l10n.editProfile)),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              24,
              24,
              24,
              MediaQuery.viewInsetsOf(context).bottom + 28,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Center(
                child: _AvatarPicker(
                  url: user?.avatarUrl,
                  isCompany: isCompany,
                  uploading: uploading.value,
                  onTap: uploading.value ? null : pickAvatar,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton.icon(
                  onPressed: uploading.value ? null : pickAvatar,
                  icon: const Icon(Icons.photo_camera_rounded, size: 18),
                  label: Text(context.l10n.changePhoto),
                ),
              ),
              const SizedBox(height: 24),
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
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => save(),
                decoration: InputDecoration(
                  hintText: isCompany
                      ? context.l10n.onboardCompanyNameHint
                      : context.l10n.onboardNicknameHint,
                ),
              ),
              if (error.value != null) ...[
                const SizedBox(height: 14),
                Text(
                  error.value!,
                  style: const TextStyle(color: AppColors.danger, fontSize: 13),
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(
                label: context.l10n.save,
                loading: saving.value,
                onPressed: name.text.trim().isEmpty ? null : save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker({
    required this.url,
    required this.isCompany,
    required this.uploading,
    required this.onTap,
  });

  final String? url;
  final bool isCompany;
  final bool uploading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: context.palette.primarySoft,
            backgroundImage: url != null ? NetworkImage(url!) : null,
            child: url == null
                ? Icon(
                    isCompany
                        ? Icons.business_rounded
                        : Icons.auto_awesome_rounded,
                    color: AppColors.primary,
                    size: 44,
                  )
                : null,
          ),
          if (uploading)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: context.palette.background, width: 2),
              ),
              child: const Icon(Icons.photo_camera_rounded,
                  color: AppColors.onPrimary, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
