import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../models/vocab_model.dart';

class TestController extends ChangeNotifier {
  List<VocabModel> vocabs = [];
  List<String> questions = [];
  List<String> answers = [];
  List<List<String>> variants = [];
  List<String?> choices = [];
  int currentQuestion = 0;
  int corrects = 0;
  bool? result;
  bool showResult = false;

  List<String> correctChoices = [];
  List<String> wrongChoices = [];
  List<String> skipped = [];

  TestController(this.vocabs) {
    init();
  }

  void init() {
    vocabs.shuffle();
    for (final vocab in vocabs) {
      questions.add(vocab.vocab);
      answers.add(vocab.meaning);
      Set<String> variants = {vocab.meaning};
      while (variants.length != 4) {
        final randomVocab = vocabs[Random().nextInt(vocabs.length - 1)];
        variants.add(randomVocab.meaning);
      }
      final result = variants.toList();
      result.shuffle();
      this.variants.add(result);
    }
    notifyListeners();
  }

  void select(String variant) {
    choices.add(variant);
    result = variant == answers[currentQuestion];
    if (result == true) {
      HapticFeedback.lightImpact();
      corrects++;
    } else {
      HapticFeedback.heavyImpact();
    }
    notifyListeners();
  }

  void next(BuildContext context) {
    if (result == null) {
      choices.add(null);
    }
    result = null;
    if (++currentQuestion == answers.length) {
      showResult = true;
      calculate();
    }
    notifyListeners();
  }

  void finishTest() {
    showResult = true;
    calculate();
    notifyListeners();
  }

  void calculate() {
    for (int i = 0; i < choices.length; i++) {
      if (choices[i] == answers[i]) {
        correctChoices.add(choices[i]!);
      } else if (choices[i] != null) {
        wrongChoices.add(choices[i]!);
      } else {
        skipped.add(answers[i]);
      }
    }
    notifyListeners();
  }

  String get getCurrentQuestion => questions[currentQuestion];

  List<String> get getCurrentVariants => variants[currentQuestion];

  Color? getColor(String variant) {
    if (result == true && variant == choices.last) {
      return CupertinoColors.systemGreen;
    } else if (result == false && variant == choices.last) {
      return CupertinoColors.systemRed;
    } else if (result != null && variant == answers[currentQuestion]) {
      return CupertinoColors.systemGreen;
    }
    return null;
  }
}
