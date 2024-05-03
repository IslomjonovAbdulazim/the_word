import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/services/local_database.dart';

class AddVocabController extends ChangeNotifier {
  final FolderModel folder;
  final List<VocabModel> vocabs;
  final VocabModel? vocab;

  late TextEditingController wordController;
  late TextEditingController meaningController;

  FocusNode wordFocusNode = FocusNode();
  FocusNode meaningFocusNode = FocusNode();

  AddVocabController(this.folder, this.vocabs, this.vocab) {
    wordController = TextEditingController(text: vocab?.vocab);
    meaningController = TextEditingController(text: vocab?.meaning);
  }

  Future<bool> save(BuildContext context) async {
    if (!_check(context)) {
      return false;
    } else {
      if (vocab == null) {
        _create();
      } else {
        _update();
      }
      return true;
    }
  }

  bool _check(BuildContext context) {
    bool word = wordController.text.trim().isEmpty;
    bool meaning = meaningController.text.trim().isEmpty;
    if (word || meaning) {
      HapticFeedback.vibrate();
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('${word ? "Word" : "Meaning"} cannot be empty'),
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
    return true;
  }

  void _update() {
    List<VocabModel> updatedVocabs = _updateTheVocab();
    final LocalDatabaseService databaseService = LocalDatabaseService();
    databaseService.saveVocabs(updatedVocabs, folder);
  }

  List<VocabModel> _updateTheVocab() {
    List<VocabModel> result = [];
    for (var vocab in vocabs) {
      if (vocab.time == this.vocab!.time) {
        vocab.vocab = wordController.text.trim();
        vocab.meaning = meaningController.text.trim();
      }
      result.add(vocab);
    }
    return result;
  }

  void _create() {
    final VocabModel vocab = VocabModel(
      time: DateTime.now(),
      meaning: meaningController.text.trim(),
      vocab: wordController.text.trim(),
      path: folder.localPath,
    );
    vocabs.add(vocab);
    final LocalDatabaseService databaseService = LocalDatabaseService();
    databaseService.saveVocabs(vocabs, folder);
  }

  void makeMeaningFocused(BuildContext context) {
    FocusScope.of(context).requestFocus(meaningFocusNode);
  }

  @override
  void dispose() {
    wordFocusNode.dispose();
    meaningFocusNode.dispose();
    wordController.dispose();
    meaningController.dispose();
    super.dispose();
  }
}
