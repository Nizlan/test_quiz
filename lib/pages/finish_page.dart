import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/quiz_repository.dart';
import 'package:quiz/pages/style.dart';

import '../cubit/quiz_cubit.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    int i = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.home)),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          return state.maybeMap(
              loaded: (value) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...value.answers
                            .map((e) => ResultRow(result: e, place: i++))
                            .toList(),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                            color: Colors.white.withOpacity(0.8),
                            child: Text(isSaved ? 'Сохранено' : 'Сохранить'),
                            onPressed: !isSaved
                                ? () {
                                    QuizRepositoryImpl().saveResult(
                                        value.category,
                                        value.difficulty,
                                        value.answers);
                                    setState(() {
                                      isSaved = true;
                                    });
                                  }
                                : null)
                      ],
                    ),
                  ),
              orElse: () => Center());
        },
      ),
    );
  }
}

class ResultRow extends StatelessWidget {
  final bool result;
  final int place;
  const ResultRow({Key? key, required this.result, required this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(place.toString()),
          result
              ? Icon(Icons.check, color: Colors.green)
              : Icon(
                  Icons.cancel_sharp,
                  color: Colors.red,
                )
        ],
      ),
    );
  }
}
