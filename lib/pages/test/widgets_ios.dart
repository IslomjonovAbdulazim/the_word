import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ResultWidgets extends StatelessWidget {
  final List<String> corrects;
  final List<String> wrongs;
  final List<String> skipped;
  final List<String> questions;
  final List<String> answers;
  final int correctsCount;
  final int attempts;

  const ResultWidgets({
    Key? key,
    required this.corrects,
    required this.wrongs,
    required this.skipped,
    required this.questions,
    required this.answers,
    required this.correctsCount,
    required this.attempts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    correctsCount.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: CupertinoColors.systemGreen,
                    ),
                  ),
                  Text(
                    "/$attempts",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            if (corrects.isNotEmpty)
              CupertinoListSection.insetGrouped(
                header: const Text(
                  "You were correct",
                  style: TextStyle(
                    color: CupertinoColors.systemGreen,
                  ),
                ),
                children: List<CupertinoListTile>.generate(
                  corrects.length,
                  (index) {
                    final i = answers.indexOf(corrects[index]);
                    return CupertinoListTile.notched(
                      title: Text(
                        questions[i],
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        answers[i],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(
                        CupertinoIcons.check_mark,
                      ),
                    );
                  },
                ),
              ),
            if (wrongs.isNotEmpty)
              CupertinoListSection.insetGrouped(
                header: const Text(
                  "You were wrong",
                  style: TextStyle(
                    color: CupertinoColors.systemRed,
                  ),
                ),
                children: List<CupertinoListTile>.generate(
                  wrongs.length,
                  (index) {
                    final i = answers.indexOf(wrongs[index]);
                    return CupertinoListTile.notched(
                      title: Text(
                        questions[i],
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        answers[i],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(
                        CupertinoIcons.repeat,
                      ),
                    );
                  },
                ),
              ),
            if (skipped.isNotEmpty)
              CupertinoListSection.insetGrouped(
                header: const Text("You just skipped"),
                children: List<CupertinoListTile>.generate(
                  skipped.length,
                  (index) {
                    final i = answers.indexOf(skipped[index]);
                    return CupertinoListTile.notched(
                      title: Text(
                        questions[i],
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        answers[i],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(
                        CupertinoIcons.question,
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: CupertinoButton(
                color: CupertinoColors.systemGreen,
                child: const Text("Back to the folder"),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
