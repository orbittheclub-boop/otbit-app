import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:orbit/core/l10n/l10n.dart';
import 'package:orbit/core/theme/app_colors.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/board/domain/entities/board_post_input.dart';
import 'package:orbit/features/board/presentation/providers/board_providers.dart';
import 'package:orbit/features/board/presentation/widgets/board_post_card.dart';

const _categories = ['free', 'question', 'tip', 'review'];

/// Compose a new board post: category + title + a rich-text body (flutter_quill).
class BoardComposeScreen extends HookConsumerWidget {
  const BoardComposeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = useState<String?>(null);
    final title = useTextEditingController();
    final controller = useMemoized(QuillController.basic);
    useEffect(() => controller.dispose, [controller]);
    final editorFocus = useFocusNode();
    final editorScroll = useScrollController();
    final loading = useState(false);
    final error = useState<String?>(null);
    useListenable(title);
    useListenable(controller); // rebuild the submit state as the body changes

    final plain = controller.document.toPlainText().trim();
    final canSubmit = category.value != null &&
        title.text.trim().isNotEmpty &&
        plain.isNotEmpty;

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      loading.value = true;
      error.value = null;
      final bodyJson =
          jsonEncode(controller.document.toDelta().toJson());
      final res = await ref.read(boardRepositoryProvider).create(
            BoardPostInput(
              category: category.value!,
              title: title.text.trim(),
              body: bodyJson,
            ),
          );
      if (!context.mounted) return;
      loading.value = false;
      switch (res) {
        case Ok():
          ref.invalidate(boardFeedProvider);
          context.pop();
        case Err(:final failure):
          error.value = failure.message;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.boardWrite),
        actions: [
          TextButton(
            onPressed: (canSubmit && !loading.value) ? submit : null,
            child: loading.value
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.primary))
                : Text(
                    context.l10n.register,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: canSubmit
                          ? AppColors.primary
                          : context.palette.textTertiary,
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in _categories)
                        ChoiceChip(
                          label: Text(boardCategoryLabel(context, c)),
                          selected: category.value == c,
                          showCheckmark: false,
                          backgroundColor: context.palette.surface,
                          selectedColor: context.palette.primarySoft,
                          side: BorderSide(
                            color: category.value == c
                                ? AppColors.primary
                                : context.palette.border,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: category.value == c
                                ? AppColors.primaryDark
                                : context.palette.textSecondary,
                          ),
                          onSelected: (_) => category.value = c,
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: title,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w800),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 12),
                      border: InputBorder.none,
                      hintText: context.l10n.boardTitleHint,
                      hintStyle: TextStyle(color: context.palette.textTertiary),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: QuillEditor(
                  controller: controller,
                  focusNode: editorFocus,
                  scrollController: editorScroll,
                  config: QuillEditorConfig(
                    placeholder: context.l10n.boardBodyHint,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            if (error.value != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(error.value!,
                      style: const TextStyle(
                          color: AppColors.danger, fontSize: 13)),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: context.palette.surface,
                border: Border(top: BorderSide(color: context.palette.border)),
              ),
              child: SafeArea(
                top: false,
                child: QuillSimpleToolbar(
                  controller: controller,
                  config: const QuillSimpleToolbarConfig(
                    multiRowsDisplay: false,
                    showFontFamily: false,
                    showFontSize: false,
                    showSearchButton: false,
                    showCodeBlock: false,
                    showSubscript: false,
                    showSuperscript: false,
                    showDividers: false,
                    showBackgroundColorButton: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
