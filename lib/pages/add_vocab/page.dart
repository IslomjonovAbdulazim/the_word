import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_word/models/vocab_model.dart';
import 'package:the_word/pages/add_vocab/controller.dart';
import 'package:the_word/pages/add_vocab/widgets_ios.dart';

class AddVocabPage extends StatelessWidget {
  final FolderModel folder;
  final List<VocabModel> vocabs;
  final VocabModel? vocab;

  const AddVocabPage({
    Key? key,
    required this.folder,
    required this.vocabs,
    this.vocab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddVocabController>(
      create: (_) => AddVocabController(folder, vocabs, vocab),
      child: Builder(builder: (context) {
        final provider = Provider.of<AddVocabController>(context);
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            middle: const Text("New vocabulary"),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                HapticFeedback.selectionClick();
                provider.save(context).then((value) {
                  if (value) {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text("Save"),
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              SizedBox(height: 10),
              WordField(),
              SizedBox(height: 10),
              MeaningField(),
            ],
          ),
        );
      }),
    );
  }
}
