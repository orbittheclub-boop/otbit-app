import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/settlement/domain/entities/settlement.dart';
import 'package:orbit/features/settlement/presentation/providers/settlement_providers.dart';

class MySettlementsScreen extends ConsumerWidget {
  const MySettlementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mySettlementsProvider);
    final won = NumberFormat('#,###');
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.mySettlements)),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(mySettlementsProvider),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => _Center('$e'),
          data: (list) => list.isEmpty
              ? _Center(context.l10n.settlementsEmpty)
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final s = list[i];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.palette.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: context.palette.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.campaignTitle ?? context.l10n.campaignFallback,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: context.palette.ink),
                                ),
                                const SizedBox(height: 4),
                                Text(s.companyName ?? context.l10n.brandFallback,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: context.palette.textSecondary)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(context.l10n.wonAmount(won.format(s.amount)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: context.palette.ink)),
                              const SizedBox(height: 4),
                              _SettleChip(s.status),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _SettleChip extends StatelessWidget {
  const _SettleChip(this.status);
  final SettlementStatus status;
  Color get _c => switch (status) {
        SettlementStatus.pending => AppColors.warning,
        SettlementStatus.processing => AppColors.primary,
        SettlementStatus.paid => AppColors.success,
      };
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: _c.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6)),
        child: Text(status.label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, color: _c)),
      );
}

class _Center extends StatelessWidget {
  const _Center(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => ListView(children: [
        const SizedBox(height: 180),
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.palette.textSecondary)),
      ]);
}
