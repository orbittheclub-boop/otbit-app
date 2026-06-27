import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/widgets/zoom_tap.dart';
import 'package:orbit/features/board/presentation/widgets/board_body.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/board/domain/entities/board_comment.dart';
import 'package:orbit/features/board/presentation/providers/board_providers.dart';
import 'package:orbit/features/board/presentation/widgets/board_post_card.dart';
import 'package:orbit/features/home/presentation/widgets/role_badge.dart';

class BoardDetailScreen extends HookConsumerWidget {
  const BoardDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(boardDetailProvider(id));
    final me = ref.watch(authControllerProvider).value;
    final commentCtrl = useTextEditingController();
    final sending = useState(false);

    Future<void> toggleLike() async {
      await ref.read(boardRepositoryProvider).toggleLike(id);
      ref.invalidate(boardDetailProvider(id));
      ref.invalidate(boardFeedProvider);
    }

    Future<void> sendComment() async {
      final text = commentCtrl.text.trim();
      if (text.isEmpty) return;
      sending.value = true;
      await ref.read(boardRepositoryProvider).addComment(id, text);
      commentCtrl.clear();
      ref.invalidate(boardDetailProvider(id));
      ref.invalidate(boardFeedProvider);
      if (!context.mounted) return;
      sending.value = false;
      FocusScope.of(context).unfocus();
    }

    Future<void> deleteComment(String cid) async {
      await ref.read(boardRepositoryProvider).deleteComment(id, cid);
      ref.invalidate(boardDetailProvider(id));
    }

    Future<void> deletePost() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(context.l10n.deletePost),
          content: Text(context.l10n.deletePostConfirm),
          actions: [
            TextButton(
                onPressed: () => context.pop(false),
                child: Text(context.l10n.cancel)),
            TextButton(
                onPressed: () => context.pop(true),
                child: Text(context.l10n.delete,
                    style: const TextStyle(color: AppColors.danger))),
          ],
        ),
      );
      if (ok != true) return;
      await ref.read(boardRepositoryProvider).deletePost(id);
      ref.invalidate(boardFeedProvider);
      if (context.mounted) context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navBoard),
        actions: [
          async.maybeWhen(
            data: (d) => d.post.authorId == me?.id
                ? IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: deletePost,
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('$e',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.palette.textSecondary)),
          ),
        ),
        data: (d) {
          final post = d.post;
          final role = boardAuthorRole(post.authorRole);
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  children: [
                    Row(
                      children: [
                        CategoryChip(post.category),
                        const Spacer(),
                        Text(boardTimeAgo(context.l10n, post.createdAt),
                            style: TextStyle(
                                fontSize: 12,
                                color: context.palette.textTertiary)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                        color: context.palette.ink,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: context.palette.primarySoft,
                          backgroundImage: post.authorAvatarUrl != null
                              ? NetworkImage(post.authorAvatarUrl!)
                              : null,
                          child: post.authorAvatarUrl == null
                              ? const Icon(Icons.person_rounded,
                                  size: 16, color: AppColors.primary)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Text(post.authorName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.palette.ink)),
                        if (role != null) ...[
                          const SizedBox(width: 8),
                          RoleBadge(role: role),
                        ],
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1),
                    const SizedBox(height: 18),
                    _RichBody(body: post.body),
                    const SizedBox(height: 24),
                    Center(
                      child: _LikeButton(
                        liked: post.liked,
                        count: post.likeCount,
                        onTap: toggleLike,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Text(
                      '${context.l10n.boardComments} ${d.comments.length}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: context.palette.ink),
                    ),
                    const SizedBox(height: 8),
                    if (d.comments.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(context.l10n.boardNoComments,
                              style: TextStyle(
                                  color: context.palette.textTertiary)),
                        ),
                      ),
                    for (final c in d.comments)
                      _CommentTile(
                        comment: c,
                        canDelete: c.authorId == me?.id,
                        onDelete: () => deleteComment(c.id),
                      ),
                  ],
                ),
              ),
              _CommentBar(
                controller: commentCtrl,
                sending: sending.value,
                onSend: sendComment,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Read-only rich-text renderer for a post body (Delta JSON or legacy plain).
class _RichBody extends HookWidget {
  const _RichBody({required this.body});
  final String body;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => QuillController(
        document: boardBodyToDocument(body),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      ),
      [body],
    );
    useEffect(() => controller.dispose, [controller]);
    final focus = useFocusNode();
    final scroll = useScrollController();
    return QuillEditor(
      controller: controller,
      focusNode: focus,
      scrollController: scroll,
      config: const QuillEditorConfig(
        scrollable: false,
        showCursor: false,
        enableInteractiveSelection: false,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton(
      {required this.liked, required this.count, required this.onTap});
  final bool liked;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTap(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          decoration: BoxDecoration(
            color: liked ? context.palette.primarySoft : context.palette.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: liked ? AppColors.primary : context.palette.border,
              width: liked ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: 19,
                color: liked ? AppColors.primary : context.palette.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                '${context.l10n.like} $count',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color:
                      liked ? AppColors.primaryDark : context.palette.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile(
      {required this.comment, required this.canDelete, required this.onDelete});
  final BoardComment comment;
  final bool canDelete;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final role = boardAuthorRole(comment.authorRole);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: context.palette.primarySoft,
            backgroundImage: comment.authorAvatarUrl != null
                ? NetworkImage(comment.authorAvatarUrl!)
                : null,
            child: comment.authorAvatarUrl == null
                ? const Icon(Icons.person_rounded,
                    size: 15, color: AppColors.primary)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(comment.authorName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: context.palette.ink)),
                    ),
                    if (role != null) ...[
                      const SizedBox(width: 6),
                      RoleBadge(role: role),
                    ],
                    const SizedBox(width: 8),
                    Text(boardTimeAgo(context.l10n, comment.createdAt),
                        style: TextStyle(
                            fontSize: 11, color: context.palette.textTertiary)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(comment.body,
                    style: const TextStyle(fontSize: 13.5, height: 1.4)),
              ],
            ),
          ),
          if (canDelete)
            InkWell(
              onTap: onDelete,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.close_rounded,
                    size: 16, color: context.palette.textTertiary),
              ),
            ),
        ],
      ),
    );
  }
}

class _CommentBar extends StatelessWidget {
  const _CommentBar(
      {required this.controller, required this.sending, required this.onSend});
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.background,
        border: Border(top: BorderSide(color: context.palette.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: context.l10n.boardCommentHint,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              sending
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.primary),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send_rounded,
                          color: AppColors.primary),
                      onPressed: onSend,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
