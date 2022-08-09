import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/quiz_cubit.dart';
import 'finish_page.dart';
import 'style.dart';

class QuizPage extends StatelessWidget {
  final String? category;
  final String? difficulty;
  const QuizPage({Key? key, required this.category, required this.difficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) => state.mapOrNull(
        loaded: (value) => value.answers.length == value.questions.length
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => FinishPage()))
            : null,
      ),
      builder: (context, state) {
        return Scaffold(
            body: state.maybeMap(
          initial: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (state) => state.answers.length < state.questions.length
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(state
                                .questions[state.currentQuestion].question)),
                      ),
                      Expanded(
                        flex: 3,
                        child: GridView.count(
                          childAspectRatio: 1.5,
                          addRepaintBoundaries: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          children: state
                              .questions[state.currentQuestion].answers.entries
                              .where((element) => element.value != null)
                              .map((e) => Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                            Style.borderRadius)),
                                    margin: EdgeInsets.all(12),
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                            Style.borderRadius),
                                        onTap: () {
                                          context
                                              .read<QuizCubit>()
                                              .answerTheQuestion(e.key ==
                                                  state
                                                      .questions[
                                                          state.currentQuestion]
                                                      .correct_answer);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: AutoSizeText(e.value!),
                                        )),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(),
          orElse: () => Center(),
        ));
      },
    );
  }
}
