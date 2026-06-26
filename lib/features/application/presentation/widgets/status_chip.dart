import 'package:flutter/material.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/application/domain/entities/application.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.status});

  final String label;
  final ApplicationStatus status;

  Color _color(BuildContext context) => switch (status) {
        ApplicationStatus.pending => AppColors.warning,
        ApplicationStatus.accepted => AppColors.success,
        ApplicationStatus.rejected => context.palette.textTertiary,
        ApplicationStatus.submitted => AppColors.primary,
        ApplicationStatus.completed => context.palette.ink,
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _color(context).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: _color(context)),
        ),
      );
}
