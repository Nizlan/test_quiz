import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  final int id;
  final String question;
  final String description;
  final Map<String, String?> answers;
  final String multiple_correct_answers;
  Map<String, String?> correct_answers;
  final String correct_answer;
  final String? explanation;
  final String? tip;
  final List<Map<String, String>> tags;
  final String category;
  final String difficulty;
  Question({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multiple_correct_answers,
    required this.correct_answers,
    required this.correct_answer,
    this.explanation,
    this.tip,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  Question copyWith({
    int? id,
    String? question,
    String? description,
    Map<String, String?>? answers,
    String? multiple_correct_answers,
    Map<String, String?>? correct_answers,
    String? correct_answer,
    String? explanation,
    String? tip,
    List<Map<String, String>>? tags,
    String? category,
    String? difficulty,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      description: description ?? this.description,
      answers: answers ?? this.answers,
      multiple_correct_answers:
          multiple_correct_answers ?? this.multiple_correct_answers,
      correct_answers: correct_answers ?? this.correct_answers,
      correct_answer: correct_answer ?? this.correct_answer,
      explanation: explanation ?? this.explanation,
      tip: tip ?? this.tip,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'description': description,
      'answers': answers,
      'multiple_correct_answers': multiple_correct_answers,
      'correct_answers': correct_answers,
      'correct_answer': correct_answer,
      'explanation': explanation,
      'tip': tip,
      'tags': tags,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
      description: map['description'] ?? '',
      answers: Map<String, String?>.from(map['answers']),
      multiple_correct_answers: map['multiple_correct_answers'] ?? '',
      correct_answers: Map<String, String?>.from(map['correct_answers']),
      correct_answer: map['correct_answer'] ?? '',
      explanation: map['explanation'],
      tip: map['tip'],
      tags: List<Map<String, String>>.from(
          map['tags']?.map((x) => Map<String, String>.from(x))),
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, description: $description, answers: $answers, multiple_correct_answers: $multiple_correct_answers, correct_answers: $correct_answers, correct_answer: $correct_answer, explanation: $explanation, tip: $tip, tags: $tags, category: $category, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.id == id &&
        other.question == question &&
        other.description == description &&
        mapEquals(other.answers, answers) &&
        other.multiple_correct_answers == multiple_correct_answers &&
        mapEquals(other.correct_answers, correct_answers) &&
        other.correct_answer == correct_answer &&
        other.explanation == explanation &&
        other.tip == tip &&
        listEquals(other.tags, tags) &&
        other.category == category &&
        other.difficulty == difficulty;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        description.hashCode ^
        answers.hashCode ^
        multiple_correct_answers.hashCode ^
        correct_answers.hashCode ^
        correct_answer.hashCode ^
        explanation.hashCode ^
        tip.hashCode ^
        tags.hashCode ^
        category.hashCode ^
        difficulty.hashCode;
  }
}
