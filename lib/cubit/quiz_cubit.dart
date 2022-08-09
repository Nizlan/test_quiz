import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/question_model.dart';
import '../data/quiz_repository.dart';

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizState.initial());

  void loadQuestions(QuizRepository quizRepository, String? category,
      String? difficulty) async {
    List<Question> questions =
        await quizRepository.getQuestions(category, difficulty);
    emit(_Loaded(
        questions: questions,
        answers: [],
        currentQuestion: 0,
        difficulty: difficulty,
        category: category));
  }

  void answerTheQuestion(bool answer) {
    state.mapOrNull(
      loaded: (state) {
        emit(_Loaded(
            difficulty: state.difficulty,
            category: state.category,
            questions: state.questions,
            answers: [...state.answers, answer],
            currentQuestion: state.currentQuestion + 1));
      },
    );
  }
}
