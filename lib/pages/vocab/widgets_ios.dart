import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/pages/add_vocab/page.dart';

class VocabFunctions {
  CupertinoListTile editVocab(BuildContext context,
      FolderModel folder,
      VoidCallback onBack,
      List<VocabModel> vocabs,
      VocabModel vocab,) {
    return CupertinoListTile.notched(
      title: const Text(
        'Edit this vocabulary',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(Icons.edit_outlined),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return AddVocabPage(
                folder: folder,
                vocabs: vocabs,
                vocab: vocab,
              );
            },
          ),
        ).then((value) {
          onBack();
        });
      },
    );
  }

  CupertinoListTile delete(BuildContext context,
      VoidCallback delete,) {
    return CupertinoListTile.notched(
      title: const Text(
        'Delete this vocabulary',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(CupertinoIcons.delete),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.vibrate();
        showAlertDialog(context, delete);
      },
    );
  }

  void showAlertDialog(BuildContext context,
      VoidCallback delete,) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: const Text('Delete this vocabulary'),
            content: const Text('You cannot undo this action'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDestructiveAction: true,
                isDefaultAction: true,
                onPressed: () {
                  delete();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }
}
