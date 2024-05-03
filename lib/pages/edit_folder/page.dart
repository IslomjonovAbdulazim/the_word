import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/edit_folder/controller.dart';
import 'package:the_word/pages/edit_folder/widgets_ios.dart';

import '../../models/vocab_model.dart';

class EditFolderPage extends StatelessWidget {
  final String path;
  final FolderModel folder;

  const EditFolderPage({
    Key? key,
    required this.path,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditFolderController>(
      create: (_) => EditFolderController(folder),
      child: Builder(
        builder: (context) {
          final provider = Provider.of<EditFolderController>(context);
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              middle: const Text("Edit this folder"),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  HapticFeedback.selectionClick();
                  provider.save(context).then((value) {
                    if (value) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: const Text("Save"),
              ),
            ),
            child: SafeArea(
              child: ListView(
                children: const [
                  SizedBox(height: 20),
                  SearchField(),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
