import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/pages/add_vocab/page.dart';
import 'package:the_word/pages/edit_folder/page.dart';
import 'package:the_word/pages/folder/page.dart';
import 'package:the_word/pages/test/page.dart';
import 'package:the_word/pages/vocab/page.dart';

import '../create_folder/page.dart';

class FolderFunctions {
  CupertinoListTile startTest(
    BuildContext context,
    List<VocabModel> vocabs,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Start a test',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(CupertinoIcons.text_badge_checkmark),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return TestPage(vocabs: vocabs);
            },
          ),
        );
      },
    );
  }

  CupertinoListTile editFolder(
    BuildContext context,
    FolderModel folder,
    VoidCallback onBack,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Edit this folder',
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
              return EditFolderPage(
                path: 'home',
                folder: folder,
              );
            },
          ),
        ).then((value) {
          onBack();
        });
      },
    );
  }

  CupertinoListTile delete(
    BuildContext context,
    VoidCallback delete,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Delete this folder',
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

  CupertinoListTile share(
    BuildContext context,
    VoidCallback share,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Share vocabularies',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(CupertinoIcons.share),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.selectionClick();
        share();
      },
    );
  }

  CupertinoListTile addFolder(
    final BuildContext context,
    final FolderModel folder,
    final List<FolderModel> folders,
    final VoidCallback onBack,
    final String path,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Add new folder',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(CupertinoIcons.add),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return CreateFolderPageIOS(
                path: path,
                folders: folders,
              );
            },
          ),
        ).then((value) {
          onBack();
        });
      },
    );
  }

  CupertinoListTile addVocab(
    BuildContext context,
    VoidCallback onBack,
    FolderModel folder,
    List<VocabModel> vocabs,
  ) {
    return CupertinoListTile.notched(
      title: const Text(
        'Add new vocabulary',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: const Icon(CupertinoIcons.add),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return AddVocabPage(
                folder: folder,
                vocabs: vocabs,
              );
            },
          ),
        ).then((value) {
          onBack();
        });
      },
    );
  }

  CupertinoListTile displayFolder(
    final FolderModel folder,
    final BuildContext context,
    final VoidCallback onBack,
    final String path,
  ) {
    return CupertinoListTile.notched(
      title: Text(
        folder.folderName,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: const Icon(CupertinoIcons.folder),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return FolderPageIOS(
                path: "$path/${folder.createdTime.toIso8601String()}",
                folder: folder,
              );
            },
          ),
        ).then((value) {
          onBack();
        });
      },
    );
  }

  CupertinoListTile displayVocab(
    final VocabModel vocab,
    final FolderModel folder,
    List<VocabModel> vocabs,
    BuildContext context,
    VoidCallback onBack,
  ) {
    return CupertinoListTile.notched(
      title: Text(
        vocab.vocab,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(vocab.meaning),
      leading: const Icon(Icons.abc),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return VocabPage(
              vocab: vocab,
              vocabs: vocabs,
              folder: folder,
            );
          },
        ),
      ).then((value) {
        onBack();
      }),
    );
  }

  void showAlertDialog(
    BuildContext context,
    VoidCallback delete,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete all inner folders and words'),
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
