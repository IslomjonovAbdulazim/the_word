import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/edit_folder/controller.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditFolderController>(
      builder: (context, EditFolderController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.words,
            placeholder: 'Category name',
            controller: controller.folderNameController,
            autofocus: true,
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            maxLength: 65,
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

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditFolderController>(
      builder: (context, EditFolderController controller, _) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // controller.createFolder().then((value) {
            //   Navigator.pop(context);
            // });
          },
          child: const Text("Save"),
        );
      },
    );
  }
}
