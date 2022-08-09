part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loaded(
      {required List<Question> questions,
      required List<bool> answers,
      required String? category,
      required String? difficulty,
      required int currentQuestion}) = _Loaded;
}
