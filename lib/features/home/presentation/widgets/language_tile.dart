import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/l10n/locale_controller.dart';
import 'package:orbit/core/theme/app_colors.dart';

class LanguageTile extends ConsumerWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = Localizations.localeOf(context).languageCode;
    final lang = supportedLanguages.firstWhere(
      (e) => e.$1.languageCode == code,
      orElse: () => supportedLanguages.first,
    );
    return ListTile(
      leading: const Icon(Icons.language_rounded, color: AppColors.primary),
      title: Text(context.l10n.language),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${lang.$2}  ${lang.$3}',
              style: TextStyle(color: context.palette.textSecondary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
      onTap: () => showLanguagePicker(context, ref),
    );
  }
}

/// Globe icon button that opens the language picker — used on the first
/// (login) screen so the language can be chosen before signing in.
class LanguageIconButton extends ConsumerWidget {
  const LanguageIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: context.l10n.language,
      icon: Icon(Icons.language_rounded, color: context.palette.textSecondary),
      onPressed: () => showLanguagePicker(context, ref),
    );
  }
}

/// Opens the localized language picker as a rounded bottom-sheet modal.
void showLanguagePicker(BuildContext context, WidgetRef ref) {
  final current = Localizations.localeOf(context).languageCode;
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: context.palette.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheet) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.palette.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.language,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: context.palette.ink,
                    ),
                  ),
                ),
              ),
              for (final (loc, flag, name) in supportedLanguages)
                _LangRow(
                  flag: flag,
                  name: name,
                  selected: loc.languageCode == current,
                  onTap: () {
                    ref.read(localeControllerProvider.notifier).set(loc);
                    Navigator.of(sheet).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
}

class _LangRow extends StatelessWidget {
  const _LangRow({
    required this.flag,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String flag;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.14) : null,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : context.palette.border,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.palette.ink,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
