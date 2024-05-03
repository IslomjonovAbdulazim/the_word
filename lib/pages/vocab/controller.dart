import 'package:flutter/cupertino.dart';
import 'package:the_word/services/local_database.dart';

import '../../models/vocab_model.dart';

class VocabController extends ChangeNotifier {
  List<VocabModel> vocabs = [];
  final FolderModel folder;
  final VocabModel vocab;

  VocabController(this.vocabs, this.folder, this.vocab);

  void loadVocabs() async {
    LocalDatabaseService databaseService = LocalDatabaseService();
    vocabs = await databaseService.loadVocabs(folder);
    notifyListeners();
  }

  void delete() async {
    vocabs.removeWhere((element) => element.time == vocab.time);
    LocalDatabaseService databaseService = LocalDatabaseService();
    databaseService.saveVocabs(vocabs, folder);
  }
}
