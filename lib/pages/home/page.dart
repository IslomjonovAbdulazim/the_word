import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/home/widgets_ios.dart';

import 'controller.dart';

class HomePageIOS extends StatelessWidget {
  const HomePageIOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Builder(builder: (context) {
        final provider = Provider.of<HomeController>(context);
        return CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor:
                    CupertinoTheme.of(context).scaffoldBackgroundColor,
                largeTitle: const Text('The Word'),
                border: null,
                stretch: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoListSection.insetGrouped(
                    children: <CupertinoListTile>[
                      addFolderTile(
                        context,
                        provider.folders,
                        provider.loadFolders,
                      ),
                      ...provider.folders.map(
                        (folder) => folderNotch(
                          folder,
                          context,
                          provider.loadFolders,
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        );
      }),
    );
  }
}
