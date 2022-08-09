import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/quiz_repository.dart';

import '../cubit/quiz_cubit.dart';
import 'quiz_page.dart';
import 'style.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? category;
  String? difficulty;
  @override
  Widget build(BuildContext context) {
    QuizRepository quizRepository = QuizRepositoryImpl();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectionRow(
              name: 'Выберите категорию',
              value: category ?? 'Any category',
              onSelect: (cat) => setState(() {
                    category = cat;
                  }),
              parameters: quizRepository.getCategories()),
          SelectionRow(
              name: 'Выберите сложность',
              value: difficulty ?? 'Any difficulty',
              onSelect: (dif) => setState(() {
                    difficulty = dif;
                  }),
              parameters: quizRepository.getDifficulties()),
          MaterialButton(
            color: Colors.white.withOpacity(0.8),
            onPressed: () => {
              context.read<QuizCubit>()
                ..loadQuestions(QuizRepositoryImpl(), category, difficulty),
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => QuizPage(
                    category: category,
                    difficulty: difficulty,
                  ),
                ),
              )
            },
            child: Text('Начать игру'),
          )
        ],
      ),
    );
  }
}

class SelectionRow extends StatelessWidget {
  final String name;
  final String? value;
  final void Function(String parameter) onSelect;
  final List<String> parameters;
  const SelectionRow(
      {Key? key,
      required this.name,
      required this.value,
      required this.onSelect,
      required this.parameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(name),
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Style.borderRadius),
                ),
                children: parameters
                    .map((e) => InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(e),
                        ),
                        onTap: () =>
                            {onSelect(e), Navigator.of(context).pop()}))
                    .toList(),
              ),
            ),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[200],
                ),
                alignment: Alignment.center,
                height: 30,
                width: MediaQuery.of(context).size.width / 2,
                child: Text(value ?? '')),
          )
        ],
      ),
    );
  }
}
