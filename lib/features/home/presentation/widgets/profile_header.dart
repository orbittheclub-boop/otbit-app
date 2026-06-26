import 'package:flutter/material.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/home/presentation/widgets/role_badge.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.subtitle,
    required this.icon,
    this.avatarUrl,
    this.role,
  });

  final String name;
  final String subtitle;
  final IconData icon;
  final String? avatarUrl;
  final Role? role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: context.palette.primarySoft,
            backgroundImage:
                avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? Icon(icon, color: AppColors.primary, size: 30)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (role != null) ...[
                  RoleBadge(role: role!),
                  const SizedBox(height: 8),
                ],
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: context.palette.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: context.palette.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
