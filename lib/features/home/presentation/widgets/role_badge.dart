import 'package:flutter/material.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';

/// Small pill showing the account type (회사 / 인플루언서). [onGradient] tweaks
/// the colors so it reads on the drawer's brand-gradient header.
class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.role, this.onGradient = false});

  final Role role;
  final bool onGradient;

  @override
  Widget build(BuildContext context) {
    final isCompany = role == Role.company;
    final label = isCompany
        ? context.l10n.accountTypeCompany
        : context.l10n.accountTypeInfluencer;
    final icon =
        isCompany ? Icons.business_rounded : Icons.auto_awesome_rounded;

    final fg = onGradient ? AppColors.onPrimary : AppColors.primaryDark;
    final bg = onGradient
        ? Colors.white.withValues(alpha: 0.28)
        : context.palette.primarySoft;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
