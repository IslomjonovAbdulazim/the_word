import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_word/models/vocab_model.dart';

class LocalDatabaseService {
  Future<void> saveFolders(List<FolderModel> folders, String path) async {
    try {
      String fullPath = "folders/$path";
      debugPrint("save: $path");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = jsonEncode(folders.map((e) => e.toJson()).toList());
      await prefs.setString(fullPath, data);
    } catch (e) {
      debugPrint("saveFolders: $e\n\n\n\n\n\n\n\n\n\n\n");
    }
  }

  Future<void> deleteFolder(FolderModel folder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("folders/${folder.localPath}");
  }

  Future<List<FolderModel>> loadFolders(String path) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final res = prefs.getString("folders/$path") ?? '[]';
      return List.from(jsonDecode(res))
          .map((e) => FolderModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("loadFolders: $e\n\n\n\n\n\n\n\n\n\n\n");
      return [];
    }
  }

  Future<List<VocabModel>> loadVocabs(FolderModel folder) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final res = prefs.getString("vocabs/${folder.localPath}/${folder.createdTime.toIso8601String()}") ?? '[]';
      return List.from(jsonDecode(res))
          .map((e) => VocabModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("loadVocabs: $e\n\n\n\n\n\n\n\n\n\n\n");
      return [];
    }
  }

  Future<void> saveVocabs(List<VocabModel> vocabs, FolderModel folder) async {
    try {
      String fullPath =
          "vocabs/${folder.localPath}/${folder.createdTime.toIso8601String()}";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = jsonEncode(vocabs.map((e) => e.toJson()).toList());
      await prefs.setString(fullPath, data);
    } catch (e) {
      debugPrint("saveVocabs: $e\n\n\n\n\n\n\n\n\n\n\n");
    }
  }
}
