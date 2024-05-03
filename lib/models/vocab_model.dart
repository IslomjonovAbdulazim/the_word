class FolderModel {
  late String folderName;
  late DateTime createdTime;
  late String localPath;

  FolderModel({
    required this.localPath,
    required this.folderName,
    required this.createdTime,
  });

  FolderModel.fromJson(Map<String, dynamic> json) {
    localPath = json['localPath'];
    folderName = json['folderName'];
    createdTime = DateTime.parse(json['createdTime']);
  }

  Map<String, dynamic> toJson() => {
        'localPath': localPath,
        'folderName': folderName,
        'createdTime': createdTime.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class VocabModel {
  late DateTime time;
  late String vocab;
  late String meaning;
  late String path;

  VocabModel({
    required this.time,
    required this.meaning,
    required this.vocab,
    required this.path,
  });

  VocabModel.fromJson(Map<String, dynamic> json) {
    time = DateTime.parse(json['time']);
    meaning = json['meaning'];
    vocab = json['vocab'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'meaning': meaning,
        'vocab': vocab,
        'path': path,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
