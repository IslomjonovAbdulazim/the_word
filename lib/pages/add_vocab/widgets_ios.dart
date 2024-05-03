import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/add_vocab/controller.dart';

class WordField extends StatelessWidget {
  const WordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddVocabController>(
      builder: (context, AddVocabController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.words,
            placeholder: 'Word',
            textInputAction: TextInputAction.next,
            focusNode: controller.wordFocusNode,
            controller: controller.wordController,
            autofocus: true,
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (_) {
              controller.makeMeaningFocused(context);
            },
            autocorrect: false,
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            maxLength: 100,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

class MeaningField extends StatelessWidget {
  const MeaningField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddVocabController>(
      builder: (context, AddVocabController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Meaning',
            focusNode: controller.meaningFocusNode,
            controller: controller.meaningController,
            textInputAction: TextInputAction.newline,
            expands: true,
            maxLines: null,
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (_) {
              controller.makeMeaningFocused(context);
            },
            autocorrect: false,
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
