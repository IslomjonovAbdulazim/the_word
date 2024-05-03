import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/services/local_database.dart';

class CreateFolderController extends ChangeNotifier {
  bool isLoading = false;
  final String path;
  final List<FolderModel> folders;
  TextEditingController folderNameController = TextEditingController();

  CreateFolderController(this.path, this.folders);

  Future<bool> createFolder(BuildContext context) async {
    final folderName = folderNameController.text.trim();
    if (folderName.isNotEmpty) {
      final FolderModel folder = FolderModel(
        localPath: path,
        folderName: folderName,
        createdTime: DateTime.now(),
      );
      final LocalDatabaseService databaseService = LocalDatabaseService();
      changeIsLoading();
      folders.add(folder);
      await databaseService.saveFolders(folders, path);
      await Future.delayed(const Duration(milliseconds: 300));
      changeIsLoading();
      return true;
    } else {
      HapticFeedback.vibrate();
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Folder name cannot be empty'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    folderNameController.dispose();
    super.dispose();
  }
}
