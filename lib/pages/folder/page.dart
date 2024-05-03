import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/vocab_model.dart';
import 'controller.dart';
import 'widgets_ios.dart';

class FolderPageIOS extends StatelessWidget {
  final String path;
  final FolderModel folder;

  const FolderPageIOS({
    Key? key,
    required this.path,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FolderController>(
      create: (_) => FolderController(path, folder),
      child: Builder(builder: (context) {
        final provider = Provider.of<FolderController>(context);
        final functions = FolderFunctions();
        return CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor:
                    CupertinoTheme.of(context).scaffoldBackgroundColor,
                largeTitle: Text(folder.folderName),
                border: null,
                stretch: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
                      if (provider.vocabularies.length > 5)
                        functions.startTest(context, provider.vocabularies),
                      functions.editFolder(
                        context,
                        folder,
                        provider.notifyListeners,
                      ),
                      if (provider.vocabularies.isNotEmpty)
                        functions.share(context, provider.share),
                      functions.delete(context, provider.delete),
                    ],
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
                      functions.addFolder(
                        context,
                        folder,
                        provider.innerFolders,
                        provider.loadFoldersAndVocabularies,
                        path,
                      ),
                      ...provider.innerFolders.map(
                        (folder) => functions.displayFolder(
                          folder,
                          context,
                          provider.loadFoldersAndVocabularies,
                          path,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
                      functions.addVocab(
                        context,
                        provider.loadFoldersAndVocabularies,
                        folder,
                        provider.vocabularies,
                      ),
                      ...provider.vocabularies.map(
                        (vocab) => functions.displayVocab(
                          vocab,
                          folder,
                          provider.vocabularies,
                          context,
                          provider.loadFoldersAndVocabularies,
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        );
      }),
    );
  }
}
