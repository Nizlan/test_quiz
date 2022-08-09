import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'question_model.dart';

abstract class QuizRepository {
  List<String> getCategories();
  List<String> getDifficulties();
  Future<List<Question>> getQuestions(String? category, String? difficulty);
  Future<void> saveResult(
      String? category, String? difficulty, List<bool> answers);
}

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<List<Question>> getQuestions(
      String? category, String? difficulty) async {
    http.Response response =
        await http.get(Uri.https('quizapi.io', 'api/v1/questions', {
      'apiKey': Constants.apiKey,
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      'limit': "10"
    }));
    List data = json.decode(response.body);
    List<Question> questions = [];
    for (var q in data) {
      questions.add(Question.fromMap(q));
    }
    return questions;
  }

  @override
  Future<void> saveResult(
      String? category, String? difficulty, List<bool> answers) async {
    category = category ?? 'Any category';
    difficulty = difficulty ?? 'Any difficulty';
    Timestamp time = Timestamp.fromDate(DateTime.now());
    final results = FirebaseFirestore.instance.collection('results');
    int correctAnswers = answers.where((element) => element == true).length;
    int wrongAnswers = answers.where((element) => element == false).length;
    final data = {
      'category': category,
      'difficulty': difficulty,
      'time': time,
      'correct answers': correctAnswers,
      'wrong answers': wrongAnswers
    };
    await results.add(data);
  }

  @override
  List<String> getCategories() {
    return [
      'Linux',
      'Bash',
      'Uncategorized',
      'Docker',
      'Sql',
      'Cms',
      'Code',
      'DevOps'
    ];
  }

  @override
  List<String> getDifficulties() {
    return ['Easy', 'Medium', 'Hard'];
  }
}
