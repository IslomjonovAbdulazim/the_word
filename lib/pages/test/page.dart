import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_word/pages/test/controller.dart';
import 'package:the_word/pages/test/widgets_ios.dart';

import '../../models/vocab_model.dart';

class TestPage extends StatelessWidget {
  final List<VocabModel> vocabs;

  const TestPage({
    Key? key,
    required this.vocabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TestController>(
      create: (_) => TestController(vocabs),
      child: Consumer<TestController>(
        builder: (_, TestController controller, __) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              trailing: controller.showResult
                  ? null
                  : Text(
                      "${controller.currentQuestion + 1}/${controller.answers.length}",
                    ),
            ),
            child: SafeArea(
              child: controller.showResult
                  ? ResultWidgets(
                      corrects: controller.correctChoices,
                      wrongs: controller.wrongChoices,
                      skipped: controller.skipped,
                      questions: controller.questions,
                      answers: controller.answers,
                      correctsCount: controller.corrects,
                      attempts: controller.choices.length,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                controller.getCurrentQuestion,
                                style: const TextStyle(
                                  color: CupertinoColors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: controller.getCurrentVariants.map(
                                (variant) {
                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: controller.result == null
                                          ? () {
                                              controller.select(variant);
                                            }
                                          : null,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CupertinoColors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            variant,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  controller.getColor(variant),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              if (controller.currentQuestion != 0)
                                const SizedBox(width: 4),
                              const SizedBox(width: 4),
                              if (controller.currentQuestion != 0)
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    HapticFeedback.selectionClick();
                                    controller.finishTest();
                                  },
                                  child: const Text(
                                    "Finish the test",
                                    style: TextStyle(
                                      color: CupertinoColors.systemRed,
                                    ),
                                  ),
                                ),
                              if (controller.currentQuestion != 0)
                                const SizedBox(width: 17.5),
                              Expanded(
                                child: CupertinoButton(
                                  color: const Color(0xff6486ff),
                                  onPressed: () {
                                    HapticFeedback.selectionClick();
                                    controller.next(context);
                                  },
                                  child: Text(
                                    controller.result != null ? "Next" : "Skip",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
