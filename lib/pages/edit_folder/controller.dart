import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:the_word/services/local_database.dart';
import '../../models/vocab_model.dart';

class EditFolderController extends ChangeNotifier {
  TextEditingController? folderNameController;
  List<FolderModel> folders = [];
  final FolderModel folder;
  String? error;

  EditFolderController(this.folder) {
    folderNameController = TextEditingController(text: folder.folderName);
    loadFolders();
  }

  void loadFolders() async {
    LocalDatabaseService databaseService = LocalDatabaseService();
    folders = await databaseService.loadFolders(folder.localPath);
    notifyListeners();
  }

  Future<bool> save(BuildContext context) async {
    if (folderNameController!.text.trim().isEmpty) {
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
    } else {
      folder.folderName = folderNameController!.text.trim();
      List<FolderModel> updatedFolders = _updateTheFolders();
      LocalDatabaseService databaseService = LocalDatabaseService();
      await databaseService.saveFolders(updatedFolders, folder.localPath);
      return true;
    }
  }

  List<FolderModel> _updateTheFolders() {
    List<FolderModel> result = [];
    for (final folder in folders) {
      if (folder.createdTime == this.folder.createdTime) {
        result.add(this.folder);
      } else {
        result.add(folder);
      }
    }
    return result;
  }

  @override
  void dispose() {
    folderNameController?.dispose();
    super.dispose();
  }
}
