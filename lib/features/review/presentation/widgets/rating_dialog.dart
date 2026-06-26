import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/review/presentation/providers/review_providers.dart';

Future<void> showRatingDialog(
  BuildContext context,
  String applicationId, {
  String title = '리뷰 남기기',
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => RatingDialog(applicationId: applicationId, title: title),
  );
}

class RatingDialog extends ConsumerStatefulWidget {
  const RatingDialog({
    super.key,
    required this.applicationId,
    this.title = '리뷰 남기기',
  });

  final String applicationId;
  final String title;

  @override
  ConsumerState<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends ConsumerState<RatingDialog> {
  int _rating = 5;
  final _comment = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await ref.read(reviewRepositoryProvider).create(
          widget.applicationId,
          rating: _rating,
          comment: _comment.text.trim().isEmpty ? null : _comment.text.trim(),
        );
    if (!mounted) return;
    switch (res) {
      case Ok():
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(
            const SnackBar(content: Text('리뷰가 등록됐어요!')));
      case Err(:final failure):
        setState(() {
          _loading = false;
          _error = failure.message;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => IconButton(
                onPressed: () => setState(() => _rating = i + 1),
                icon: Icon(
                  i < _rating ? Icons.star_rounded : Icons.star_border_rounded,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
            ),
          ),
          TextField(
            controller: _comment,
            decoration: const InputDecoration(hintText: '후기 (선택)'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!,
                style: const TextStyle(color: AppColors.danger, fontSize: 12)),
          ],
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소')),
        TextButton(
          onPressed: _loading ? null : _save,
          child: _loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('등록'),
        ),
      ],
    );
  }
}
