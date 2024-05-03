import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:the_word/pages/create_folder/page.dart';
import 'package:the_word/pages/folder/page.dart';

import '../../models/vocab_model.dart';

CupertinoListTile addFolderTile(
  BuildContext context,
  List<FolderModel> folders,
  VoidCallback onBack,
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
                path: 'home',
                folders: folders,
              );
            },
          ),
        ).then(
          (value) {
            onBack();
          },
        );
      });
}

CupertinoListTile folderNotch(
  FolderModel folder,
  BuildContext context,
  VoidCallback onBack,
) {
  return CupertinoListTile.notched(
    title: Text(
      folder.folderName,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ),
    leading: const Icon(CupertinoIcons.folder, size: 20),
    trailing: const CupertinoListTileChevron(),
    onTap: () => Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return FolderPageIOS(
            path: 'home/${folder.createdTime.toIso8601String()}',
            folder: folder,
          );
        },
      ),
    ).then((value) {
      onBack();
    }),
  );
}
