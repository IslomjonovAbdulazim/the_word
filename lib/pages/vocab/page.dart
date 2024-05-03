import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/pages/vocab/controller.dart';
import 'package:the_word/pages/vocab/widgets_ios.dart';

class VocabPage extends StatelessWidget {
  final VocabModel vocab;
  final List<VocabModel> vocabs;
  final FolderModel folder;

  const VocabPage({
    Key? key,
    required this.vocab,
    required this.vocabs,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VocabController>(
      create: (_) => VocabController(vocabs, folder, vocab),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Vocabulary"),
        ),
        child: Builder(builder: (context) {
          final functions = VocabFunctions();
          final provider = Provider.of<VocabController>(context);
          return ListView(
            children: [
              CupertinoListSection.insetGrouped(
                children: <CupertinoListTile>[
                  functions.editVocab(
                    context,
                    folder,
                    provider.loadVocabs,
                    vocabs,
                    vocab,
                  ),
                  functions.delete(context, provider.delete),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Word",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      vocab.vocab,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6486ff),
                      ),
                    ),
                    const Divider(),
                    const Text(
                      "Meaning",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      vocab.meaning,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6486ff),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
