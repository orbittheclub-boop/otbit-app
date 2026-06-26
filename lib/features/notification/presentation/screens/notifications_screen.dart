import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/features/notification/domain/entities/app_notification.dart';
import 'package:orbit/features/notification/presentation/providers/notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(notificationRepositoryProvider).markRead();
              ref.invalidate(notificationsProvider);
            },
            child: const Text('모두 읽음'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(notificationsProvider),
        child: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => _Center('$e'),
          data: (feed) => feed.items.isEmpty
              ? const _Center('새로운 알림이 없어요.')
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 8, bottom: 100),
                  itemCount: feed.items.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (_, i) =>
                      _Tile(notification: feed.items[i]),
                ),
        ),
      ),
    );
  }
}

class _Tile extends ConsumerWidget {
  const _Tile({required this.notification});
  final AppNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = notification.readAt == null;
    final time = notification.createdAt;
    return InkWell(
      onTap: () async {
        await ref
            .read(notificationRepositoryProvider)
            .markRead(id: notification.id);
        ref.invalidate(notificationsProvider);
      },
      child: Container(
        color: unread ? context.palette.primarySoft.withValues(alpha: 0.4) : null,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6, right: 10),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: unread ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? '알림',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: context.palette.ink,
                        fontSize: 15),
                  ),
                  if (notification.body != null) ...[
                    const SizedBox(height: 2),
                    Text(notification.body!,
                        style: TextStyle(
                            color: context.palette.textSecondary, fontSize: 13)),
                  ],
                  if (time != null) ...[
                    const SizedBox(height: 6),
                    Text(DateFormat('MM.dd HH:mm').format(time),
                        style: TextStyle(
                            color: context.palette.textTertiary, fontSize: 11)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Center extends StatelessWidget {
  const _Center(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => ListView(children: [
        const SizedBox(height: 200),
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.palette.textSecondary)),
      ]);
}
