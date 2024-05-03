import 'package:flutter/cupertino.dart';
import 'package:the_word/services/local_database.dart';

import '../../models/vocab_model.dart';

class HomeController extends ChangeNotifier {
  List<FolderModel> folders = [];

  HomeController() {
    loadFolders();
  }

  void loadFolders() async {
    LocalDatabaseService databaseService = LocalDatabaseService();
    folders = await databaseService.loadFolders('home');
    notifyListeners();
  }
}
