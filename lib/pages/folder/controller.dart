import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_word/services/local_database.dart';
import '../../models/vocab_model.dart';

class FolderController extends ChangeNotifier {
  List<FolderModel> innerFolders = [];
  List<VocabModel> vocabularies = [];
  final String path;
  final FolderModel folder;

  FolderController(this.path, this.folder) {
    loadFoldersAndVocabularies();
  }

  Future<void> loadFoldersAndVocabularies() async {
    LocalDatabaseService databaseService = LocalDatabaseService();
    innerFolders = await databaseService.loadFolders(path);
    vocabularies = await databaseService.loadVocabs(folder);
    notifyListeners();
  }

  Future<void> delete() async {
    LocalDatabaseService databaseService = LocalDatabaseService();
    String path = folder.localPath;
    final folders = await databaseService.loadFolders(path);
    folders.removeWhere((element) => folder.createdTime == element.createdTime);
    await databaseService.saveFolders(folders, path);
  }

  void share() {
    String vocabs = "";
    for (var vocab in vocabularies) {
      vocabs += "${vocab.vocab} - ${vocab.meaning}\n";
    }
    Share.share(vocabs);
  }
}
