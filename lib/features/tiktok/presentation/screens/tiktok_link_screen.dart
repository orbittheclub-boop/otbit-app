import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/core/widgets/primary_button.dart';
import 'package:orbit/features/tiktok/domain/entities/tiktok_account.dart';
import 'package:orbit/features/tiktok/presentation/providers/tiktok_providers.dart';

/// Custom URL scheme registered for the TikTok OAuth redirect (configure the
/// matching `TIKTOK_REDIRECT_URI=orbit://tiktok` secret + native intent/scheme).
const _callbackScheme = 'orbit';

class TiktokLinkScreen extends ConsumerWidget {
  const TiktokLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(tiktokAccountProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('TikTok 연동')),
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(
            child: Text('$e',
                style: TextStyle(color: context.palette.textSecondary))),
        data: (acct) =>
            acct == null ? const _NotLinked() : _Linked(account: acct),
      ),
    );
  }
}

Future<void> _startLink(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final urlRes = await ref.read(tiktokRepositoryProvider).authorizeUrl();
  switch (urlRes) {
    case Err(:final failure):
      messenger.showSnackBar(SnackBar(
          content: Text(failure.message == 'tiktok_not_configured'
              ? 'TikTok 앱 설정이 아직 안 됐어요 (관리자 설정 필요).'
              : failure.message)));
      return;
    case Ok(:final value):
      try {
        final result = await FlutterWebAuth2.authenticate(
          url: value,
          callbackUrlScheme: _callbackScheme,
        );
        final code = Uri.parse(result).queryParameters['code'];
        if (code == null) {
          messenger.showSnackBar(
              const SnackBar(content: Text('인증 코드를 받지 못했어요.')));
          return;
        }
        final linkRes = await ref.read(tiktokRepositoryProvider).linkWithCode(code);
        switch (linkRes) {
          case Ok():
            ref.invalidate(tiktokAccountProvider);
            messenger.showSnackBar(
                const SnackBar(content: Text('TikTok 연동 완료!')));
          case Err(:final failure):
            messenger.showSnackBar(SnackBar(content: Text(failure.message)));
        }
      } catch (_) {
        messenger.showSnackBar(const SnackBar(content: Text('연동이 취소됐어요.')));
      }
  }
}

class _NotLinked extends ConsumerWidget {
  const _NotLinked();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.music_note_rounded, size: 64, color: AppColors.primary),
          const SizedBox(height: 20),
          Text(
            'TikTok 계정을 연동하세요',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.palette.ink),
          ),
          const SizedBox(height: 10),
          Text(
            '본인 인증과 팔로워 통계를 가져와\n캠페인 지원 시 포트폴리오로 보여줘요.',
            textAlign: TextAlign.center,
            style: TextStyle(color: context.palette.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'TikTok 연동하기',
            icon: Icons.link_rounded,
            onPressed: () => _startLink(context, ref),
          ),
        ],
      ),
    );
  }
}

class _Linked extends ConsumerWidget {
  const _Linked({required this.account});
  final TiktokAccount account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = NumberFormat.compact();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: context.palette.primarySoft,
              backgroundImage: account.avatarUrl != null
                  ? NetworkImage(account.avatarUrl!)
                  : null,
              child: account.avatarUrl == null
                  ? const Icon(Icons.music_note_rounded,
                      color: AppColors.primary)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.displayName ?? account.username ?? 'TikTok',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: context.palette.ink)),
                  if (account.username != null)
                    Text('@${account.username}',
                        style: TextStyle(
                            color: context.palette.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.verified_rounded, color: AppColors.primary),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _Stat(label: '팔로워', value: n.format(account.followerCount ?? 0)),
            _Stat(label: '팔로잉', value: n.format(account.followingCount ?? 0)),
            _Stat(label: '좋아요', value: n.format(account.likesCount ?? 0)),
            _Stat(label: '영상', value: n.format(account.videoCount ?? 0)),
          ],
        ),
        const SizedBox(height: 28),
        SecondaryButton(
          label: '통계 새로고침',
          icon: Icons.refresh_rounded,
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            final res = await ref.read(tiktokRepositoryProvider).refreshStats();
            ref.invalidate(tiktokAccountProvider);
            if (res is Err) {
              messenger.showSnackBar(
                  SnackBar(content: Text((res as Err).failure.message)));
            }
          },
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () async {
            await ref.read(tiktokRepositoryProvider).unlink();
            ref.invalidate(tiktokAccountProvider);
          },
          child: const Text('연동 해제', style: TextStyle(color: AppColors.danger)),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: context.palette.ink)),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12, color: context.palette.textSecondary)),
          ],
        ),
      );
}
