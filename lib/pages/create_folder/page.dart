import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/create_folder/controller.dart';
import 'package:the_word/pages/create_folder/widgets_ios.dart';

import '../../models/vocab_model.dart';

class CreateFolderPageIOS extends StatelessWidget {
  final String path;
  final List<FolderModel> folders;

  const CreateFolderPageIOS({
    Key? key,
    required this.path,
    required this.folders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateFolderController>(
      create: (_) => CreateFolderController(path, folders),
      child: Builder(builder: (context) {
        final provider = Provider.of<CreateFolderController>(context);
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            middle: const Text("New folder"),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                HapticFeedback.selectionClick();
                provider.createFolder(context).then((value) {
                  if (value) {
                    Navigator.pop(context);
                  }
                });
              },
              child: provider.isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text("Save"),
            ),
          ),
          child: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: const [
                SizedBox(height: 20),
                SearchField(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
